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
    FileUtils.cp SOURCE_DIRECTORY/"src/main.cpp", @directory/"src/main.cpp"
  end

  def teardown
    FileUtils.rm_rf @directory
  end

  def test_upstream_patch_and_qt_runtime
    Dir.chdir(@directory) { @formula.modernize_ui }
    source = (@directory/"src/main.cpp").read
    setup = source.match(/KleopatraApplication app\(argc, argv\);(.*?)KCrash::initialize\(\);/m)[1]
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
                                                  "-framework", "QtGui", "-framework", "QtCore", "-o", "theme"

      _, errors, status = Open3.capture3({ "QT_QPA_PLATFORM" => "offscreen" }, "./theme")
      assert status.success? && !errors.match?(/Could not parse|Unknown property/), errors
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
