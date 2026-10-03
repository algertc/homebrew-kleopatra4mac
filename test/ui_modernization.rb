# typed: true
# frozen_string_literal: true

require "formula"
require "minitest/autorun"
require "tmpdir"
require "open3"

SOURCE_DIRECTORY = Pathname(ARGV.shift || raise("Pass the extracted Kleopatra v22.07.80 source directory")).freeze

class UiModernizationTest < Minitest::Test
  def setup
    @formula = Formulary.factory("kayyo321/kleopatra4mac/kleopatra")
    @directory = Pathname(Dir.mktmpdir("kleopatra-ui-test"))
    (@directory/"src").mkpath
    %w[main.cpp mainwindow.cpp CMakeLists.txt].each do |file|
      FileUtils.cp SOURCE_DIRECTORY/"src"/file, @directory/"src"/file
    end
  end

  def teardown
    FileUtils.rm_rf @directory
  end

  def test_upstream_patch_and_qt_runtime
    Dir.chdir(@directory) { @formula.modernize_ui }
    source = (@directory/"src/main.cpp").read
    setup = source.match(/KleopatraApplication app\(argc, argv\);(.*?)KCrash::initialize\(\);/m)[1]
    setup += source.match(/KAboutData::setApplicationData\(aboutData\);(.*?)if \(Kleo::userIsElevated/m)[1]
    original = @directory/"original.app"
    (original/"Contents/MacOS").mkpath
    (original/"Contents/Resources").mkpath
    FileUtils.cp Pathname(@formula.path).dirname/"images/icon.png", original/"Contents/Resources/kleopatra.png"
    setup = setup.sub("app.setStyleSheet", <<~CPP)
      if (app.style()->objectName() != QStringLiteral("fusion")) { return 1; }
      app.setStyleSheet
    CPP
    (@directory/"theme.cpp").write <<~CPP
      #include <QApplication>
      #include <QStyle>
      #include <QStyleFactory>
      #include <QPalette>
      #include <QColor>
      #include <QIcon>
      #include <QDialog>
      #include <QMainWindow>
      #include <QMenuBar>
      #include <QMenu>
      #include <QStatusBar>
      #include <QToolBar>
      #include <QToolButton>
      #include <QTreeWidget>
      #include <QTableWidget>
      #include <QTabWidget>
      #include <QPushButton>
      #include <QLineEdit>
      #include <QTextEdit>
      #include <QScrollBar>
      #include <QVBoxLayout>
      int main(int argc, char **argv) {
          QApplication app(argc, argv);
          #{setup}
          if (app.palette().color(QPalette::Window) != QColor(35, 38, 41)
              || app.palette().color(QPalette::Highlight) != QColor(61, 174, 233)
              || app.palette().color(QPalette::Disabled, QPalette::Text) != QColor(122, 127, 131)) {
              return 2;
          }
          QDialog dialog;
          if (app.windowIcon().pixmap(32, 32).isNull() || dialog.windowIcon().pixmap(32, 32).isNull()) { return 7; }
          QMainWindow window;
          window.menuBar()->addMenu(QStringLiteral("Test"))->addAction(QStringLiteral("Action"));
          window.statusBar()->showMessage(QStringLiteral("Ready"));
          window.addToolBar(QStringLiteral("Actions"))->addAction(QStringLiteral("Import"));
          auto central = new QWidget(&window);
          auto layout = new QVBoxLayout(central);
          auto tabs = new QTabWidget(central);
          auto tree = new QTreeWidget(tabs);
          tree->setHeaderLabels({QStringLiteral("Name"), QStringLiteral("Email")});
          tree->setAlternatingRowColors(true);
          for (int i = 0; i < 30; ++i) {
              new QTreeWidgetItem(tree, {QString::number(i), QStringLiteral("test@example.com")});
          }
          tree->setCurrentItem(tree->topLevelItem(0));
          tabs->addTab(tree, QStringLiteral("Certificates"));
          tabs->addTab(new QTextEdit(QStringLiteral("Notepad sample"), tabs), QStringLiteral("Notepad"));
          auto table = new QTableWidget(3, 2, tabs);
          table->setHorizontalHeaderLabels({QStringLiteral("Status"), QStringLiteral("Fingerprint")});
          table->setItem(0, 0, new QTableWidgetItem(QStringLiteral("Valid")));
          table->selectRow(0);
          tabs->addTab(table, QStringLiteral("Details"));
          layout->addWidget(new QLineEdit(QStringLiteral("Search"), central));
          layout->addWidget(tabs);
          auto button = new QPushButton(QStringLiteral("Disabled"), central);
          button->setEnabled(false);
          layout->addWidget(button);
          auto action = new QPushButton(QStringLiteral("Export"), central);
          action->setDefault(true);
          layout->addWidget(action);
          window.setCentralWidget(central);
          window.resize(640, 480);
          window.show();
          app.processEvents();
          window.ensurePolished();
          if (window.palette().color(QPalette::Window).alpha() != 224) { return 6; }
          if (tree->verticalScrollBar()->width() != 10) { return 5; }
          for (int index = 0; index < tabs->count(); ++index) {
              tabs->setCurrentIndex(index);
              app.processEvents();
              if (window.grab().isNull()) { return 3; }
          }
          action->setFocus();
          action->setDown(true);
          app.processEvents();
          return window.grab().isNull() ? 4 : 0;
      }
    CPP
    Dir.chdir(@directory) do
      raise "Qt compilation failed" unless system "/usr/bin/clang++", "-std=c++17", "-fPIC", "theme.cpp",
                                                  "-I#{Utils::Path.formula_opt_lib("qt@5")}/QtWidgets.framework/Headers",
                                                  "-I#{Utils::Path.formula_opt_lib("qt@5")}/QtGui.framework/Headers",
                                                  "-I#{Utils::Path.formula_opt_lib("qt@5")}/QtCore.framework/Headers",
                                                  "-F#{Utils::Path.formula_opt_lib("qt@5")}",
                                                  "-framework", "QtWidgets",
                                                  "-framework", "QtGui", "-framework", "QtCore",
                                                  "-o", (original/"Contents/MacOS/theme").to_s

      FileUtils.mv original, @directory/"relocated.app"
      _, errors, status = Open3.capture3({ "QT_QPA_PLATFORM" => "offscreen" },
                                         (@directory/"relocated.app/Contents/MacOS/theme").to_s)
      assert status.success? && !errors.match?(/Could not parse|Unknown property/), errors
    end
  end

  def test_native_vibrancy_lifecycle
    Dir.chdir(@directory) { @formula.modernize_window }
    constructor = (@directory/"src/mainwindow.cpp").read.match(
      /: KXmlGuiWindow\(parent, flags\), d\(new Private\(this\)\)\s*\{(.*?)\}/m,
    )[1]
    (@directory/"vibrancy.mm").write <<~CPP
      #import <AppKit/AppKit.h>
      #include <QApplication>
      #include <QMainWindow>
      void applyMacVibrancy(WId windowId);
      int main(int argc, char **argv) {
          QApplication app(argc, argv);
          QMainWindow window;
          auto central = new QWidget(&window);
          central->setAutoFillBackground(true);
          window.setCentralWidget(central);
          auto setAttribute = [&window](Qt::WidgetAttribute attribute, bool value) { window.setAttribute(attribute, value); };
          auto centralWidget = [&window]() { return window.centralWidget(); };
          #{constructor}
          if (!window.testAttribute(Qt::WA_TranslucentBackground) || central->autoFillBackground()) { return 3; }
          window.resize(640, 480);
          window.show();
          app.processEvents();
          applyMacVibrancy(window.winId());
          applyMacVibrancy(window.winId());
          window.hide();
          window.show();
          applyMacVibrancy(window.winId());
          window.resize(800, 600);
          app.processEvents();
          NSView *view = reinterpret_cast<NSView *>(window.winId());
          int effects = 0;
          for (NSView *child in view.subviews) {
              if ([child isKindOfClass:NSVisualEffectView.class]) {
                  ++effects;
                  NSVisualEffectView *effect = static_cast<NSVisualEffectView *>(child);
                  if (effect.material != NSVisualEffectMaterialUnderWindowBackground
                      || effect.blendingMode != NSVisualEffectBlendingModeBehindWindow
                      || !NSEqualRects(effect.frame, view.bounds)) { return 1; }
              }
          }
          return effects == 1 && !view.window.opaque ? 0 : 2;
      }
    CPP
    Dir.chdir(@directory) do
      raise "Cocoa compilation failed" unless system "/usr/bin/clang++", "-std=c++17", "vibrancy.mm",
                                                     "src/macvibrancy.mm",
                                                     "-I#{Utils::Path.formula_opt_lib("qt@5")}/QtWidgets.framework/Headers",
                                                     "-I#{Utils::Path.formula_opt_lib("qt@5")}/QtGui.framework/Headers",
                                                     "-I#{Utils::Path.formula_opt_lib("qt@5")}/QtCore.framework/Headers",
                                                     "-F#{Utils::Path.formula_opt_lib("qt@5")}",
                                                     "-framework", "QtWidgets", "-framework", "QtGui",
                                                     "-framework", "QtCore", "-framework", "AppKit", "-o", "vibrancy"

      _, errors, status = Open3.capture3({ "QT_QPA_PLATFORM" => "cocoa" }, "./vibrancy")
      assert status.success?, errors
    end
  end

  def test_generated_iconset
    iconset = @formula.create_iconset(@directory)
    dimensions = iconset.children.to_h do |file|
      output, status = Open3.capture2("/usr/bin/sips", "-g", "pixelWidth", "-g", "pixelHeight", file.to_s)
      raise "Icon inspection failed" unless status.success?

      [file.basename.to_s, output.scan(/pixel(?:Width|Height): (\d+)/).flatten.map(&:to_i)]
    end
    assert_equal({
      "icon_16x16.png" => [16, 16], "icon_16x16@2x.png" => [32, 32],
      "icon_32x32.png" => [32, 32], "icon_32x32@2x.png" => [64, 64],
      "icon_128x128.png" => [128, 128], "icon_128x128@2x.png" => [256, 256],
      "icon_256x256.png" => [256, 256], "icon_256x256@2x.png" => [512, 512],
      "icon_512x512.png" => [512, 512], "icon_512x512@2x.png" => [1024, 1024]
    }, dimensions)
  end

  def test_bundle_icon_installation
    iconset = @formula.create_iconset(@directory)
    bundle = @directory/"kleopatra.app"
    (bundle/"Contents").mkpath
    (bundle/"Contents/Info.plist").write <<~PLIST
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0"><dict><key>CFBundleIconFile</key><string>legacy.icns</string></dict></plist>
    PLIST
    @formula.install_modern_icon(iconset, bundle)
    resources = bundle/"Contents/Resources"
    raise "Icon archive missing" if (resources/"kleopatra.icns").read(4) != "icns"
    raise "Runtime icon missing" unless (resources/"kleopatra.png").size.positive?

    output, status = Open3.capture2("/usr/libexec/PlistBuddy", "-c", "Print :CFBundleIconFile",
                                    (bundle/"Contents/Info.plist").to_s)
    assert status.success? && output.strip == "kleopatra.icns"
  end

  def test_missing_native_window_anchor_fails
    source = @directory/"src/mainwindow.cpp"
    source.write source.read.sub("KXmlGuiWindow::showEvent(e);", "KXmlGuiWindow::showEvent(event);")
    capture_io do
      assert_raises(BuildError) { Dir.chdir(@directory) { @formula.modernize_window } }
    end
  end

  def test_missing_native_build_anchor_fails
    source = @directory/"src/CMakeLists.txt"
    source.write source.read.sub("add_executable(kleopatra_bin", "add_executable(renamed_bin")
    capture_io do
      assert_raises(BuildError) { Dir.chdir(@directory) { @formula.modernize_window } }
    end
  end

  def test_missing_startup_anchor_fails
    source = @directory/"src/main.cpp"
    source.write source.read.sub("KleopatraApplication app(argc, argv);", "KleopatraApplication renamed(argc, argv);")
    capture_io do
      assert_raises(BuildError) { Dir.chdir(@directory) { @formula.modernize_ui } }
    end
  end
end
