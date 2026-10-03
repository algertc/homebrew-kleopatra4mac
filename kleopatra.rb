# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula

class Kleopatra < Formula
  desc "Certificate manager and GUI for OpenPGP and CMS cryptography"
  homepage "https://invent.kde.org/pim/kleopatra"
  url "https://github.com/KDE/kleopatra/archive/refs/tags/v22.07.80.tar.gz"
  sha256 "92642a820fe8ca17b8ba29f8c8e72023765a075422fb37eef82d85bf67729a25"
  license all_of: ["GPL-2.0-only", "GPL-3.0-only", "LGPL-2.1-only", "LGPL-3.0-only"]
  keg_only "not linked to prevent conflicts with any gpgme or kde libs"

  bottle do
    root_url "https://github.com/algertc/homebrew-kleopatra4mac/releases/download/latest"
    sha256 monterey:       "5a3a4892a6ba475bd7e759dc08b4537182964b0fe650545c383aba921ad12803"
    sha256 arm64_monterey: "b3a7b265427c680b16bf1dacc03ebf6b4c5c3a7d96d5fd13b067cc0b50946467"
  end

  depends_on "boost" => :build
  depends_on "cmake" => :build
  depends_on "extra-cmake-modules" => :build
  depends_on "iso-codes" => :build
  depends_on "pkg-config" => :build
  depends_on "python3" => :build

  depends_on "dbus"
  depends_on "docbook-xsl"
  depends_on "gnupg"
  depends_on "libassuan"
  depends_on "libgpg-error"
  depends_on "qt@5"
  depends_on "zstd"

  uses_from_macos "zip"

  # qgpgme, gpgmepp
  resource "gpgme" do
    url "https://www.gnupg.org/ftp/gcrypt/gpgme/gpgme-1.17.1.tar.bz2"
    sha256 "711eabf5dd661b9b04be9edc9ace2a7bc031f6bd9d37a768d02d0efdef108f5f"
  end

  resource "gpgmepp" do
    url "https://github.com/KDE/gpgmepp/archive/refs/tags/v16.08.3.tar.gz"
    sha256 "b988830a88448703128bc2bd2830e8aad2732b3ad45b6f26360b8da358cd9a96"
  end

  # knotifications depends on it
  resource "phonon" do
    url "https://github.com/KDE/phonon/archive/refs/tags/v4.11.1.tar.gz"
    sha256 "94e782d1499a7b264122cf09aa559d6245b869d4c33462d82dd1eb294c132e1b"
  end

  # ktextwidgets depends on it
  resource "sonnet" do
    url "https://github.com/KDE/sonnet/archive/refs/tags/v5.96.0.tar.gz"
    sha256 "df94279e92c8b5069a5524e00fa236cc6d66e7a356d25bbc266808a6770518f2"
  end

  # KF5 libraries
  resource "karchive" do
    url "https://github.com/KDE/karchive/archive/refs/tags/v5.96.0.tar.gz"
    sha256 "5870cee093d2e079009f9c88a36eb59bc9880b57623232ccaa49ef3ae1a0d405"
  end

  resource "kcoreaddons" do
    url "https://github.com/KDE/kcoreaddons/archive/refs/tags/v5.96.0.tar.gz"
    sha256 "912ac4cd9684827d06900457987dc6b98836291fdb6753ce797ab950b845445a"
  end

  resource "kauth" do
    url "https://github.com/KDE/kauth/archive/refs/tags/v5.96.0.tar.gz"
    sha256 "dfa93902fe8992dabc80267d081610402dbdae7baae35b174e74700b65103681"
  end

  resource "kcodecs" do
    url "https://github.com/KDE/kcodecs/archive/refs/tags/v5.96.0.tar.gz"
    sha256 "85ed0bfca75a8e33311dc51ab752a502f5904e5250402c20c4f95728749fc300"
  end

  resource "kconfig" do
    url "https://github.com/KDE/kconfig/archive/refs/tags/v5.96.0.tar.gz"
    sha256 "ae2bd8facc531fa9a508204dfdb337f53b7ecc42bb944147dd0cff8da8e2c0ff"
  end

  resource "kwidgetsaddons" do
    url "https://github.com/KDE/kwidgetsaddons/archive/refs/tags/v5.96.0.tar.gz"
    sha256 "42d26175e1956d3dc2d82ef50f4a3d790b51fb546e7cfa90cb1cf8c7373e01ae"
  end

  resource "kcompletion" do
    url "https://github.com/KDE/kcompletion/archive/refs/tags/v5.96.0.tar.gz"
    sha256 "560825a476c12b19a1427ecc071b2b3d6d798ea363e45d5f2fb73941da2a5cf6"
  end

  resource "kguiaddons" do
    url "https://github.com/KDE/kguiaddons/archive/refs/tags/v5.96.0.tar.gz"
    sha256 "3a77bb3a5e3913d919fe8827962e7bdba61dda98d944c238d389f765f597a14f"
  end

  resource "ki18n" do
    url "https://github.com/KDE/ki18n/archive/refs/tags/v5.96.0.tar.gz"
    sha256 "c0c8b5b4986a80037f064a3fbde159c0f15a845423d6a5f0aad3a39bd5cc2b76"
  end

  resource "kconfigwidgets" do
    url "https://github.com/KDE/kconfigwidgets/archive/refs/tags/v5.96.0.tar.gz"
    sha256 "8cec04ede72d7e5f6e927d3631759a4380cc4e356211a4abac50b871ebf8f153"
  end

  resource "kcrash" do
    url "https://github.com/KDE/kcrash/archive/refs/tags/v5.96.0.tar.gz"
    sha256 "627a88c6853cdaaf9e1cd976150eba2b460ca26bcf20c4045b197a351bbed555"
  end

  resource "kwindowsystem" do
    url "https://github.com/KDE/kwindowsystem/archive/refs/tags/v5.96.0.tar.gz"
    sha256 "066dbba360c9f46ea660ab84cee60207ca6e3edfddc3ecd841f8b4e03f0770d2"
  end

  resource "kdbusaddons" do
    url "https://github.com/KDE/kdbusaddons/archive/refs/tags/v5.96.0.tar.gz"
    sha256 "9521b07ca701c3b49b134cc38902fbd4ec13706124bc2a98986f77af2b63e66a"
  end

  resource "kdoctools" do
    url "https://github.com/KDE/kdoctools/archive/refs/tags/v5.96.0.tar.gz"
    sha256 "0bc28f51f3e18ee271992034fa30b45ac70df4fc6625afe2a390220c3f1a43ed"
  end

  resource "kitemviews" do
    url "https://github.com/KDE/kitemviews/archive/refs/tags/v5.96.0.tar.gz"
    sha256 "d450ba84b72647c9bbc2e438bb4ca100550d8558d1b15eaf471741e7fa4f529b"
  end

  resource "kiconthemes" do
    url "https://github.com/KDE/kiconthemes/archive/refs/tags/v5.96.0.tar.gz"
    sha256 "6c198b5bafbb7cbd4ca2204bb09ad39433e30697cda1fce7c848e21471d6d18c"
  end

  resource "kitemmodels" do
    url "https://github.com/KDE/kitemmodels/archive/refs/tags/v5.96.0.tar.gz"
    sha256 "e31d430c8600bc2ab224684f9915d3d6114d65b38aafe945615ab1acfcedd90c"
  end

  resource "kmime" do
    url "https://github.com/KDE/kmime/archive/refs/tags/v22.07.80.tar.gz"
    sha256 "0e4d8adfefdb6b8d67d6c13c52e6375ee6754c1d49230c3bc8f66b9f626fef75"
  end

  resource "knotifications" do
    url "https://github.com/KDE/knotifications/archive/refs/tags/v5.96.0.tar.gz"
    sha256 "c94a188f81406d2d89091314a9cc8242f9c03d9567f4d6121f75c86feb20a831"
  end

  resource "ktextwidgets" do
    url "https://github.com/KDE/ktextwidgets/archive/refs/tags/v5.96.0.tar.gz"
    sha256 "1ce7d0974c696f9a3cbb74c5479a2af333ba0bc03889773bd9f718b4b7311e79"
  end

  resource "kxmlgui" do
    url "https://github.com/KDE/kxmlgui/archive/refs/tags/v5.96.0.tar.gz"
    sha256 "3eb924c2033f036d94fb498ab46fbec6a0fa7dee7bfd99d46bb62275e1b7e6a4"
  end
  # end of KF5 libs

  resource "libkleo" do
    url "https://github.com/KDE/libkleo/archive/refs/tags/v22.07.80.tar.gz"
    sha256 "c70556e7b462dfc120e3af660975dd121e36aa11b7f3082286e0d0a08652b275"
  end

  def install
    args = std_cmake_args

    # qgpgme, gpgmepp
    resource("gpgme").stage do
      system "./configure --prefix=#{prefix}"

      # Not sure if all ramining folders need this flag
      inreplace "lang/qt/src/Makefile" do |s|
        s.gsub!(/\-std=c\+\+11/, "-std=c++17")
      end
      inreplace "lang/qt/tests/Makefile" do |s|
        s.gsub!(/\-std=c\+\+11/, "-std=c++17")
      end

      system "make", "install"
    end

    resource("gpgmepp").stage do
      system "cmake", ".", *args
      system "make", "install", "prefix=#{prefix}"
    end

    # KF5 depends on it
    resource("phonon").stage do
      system "cmake", ".", *args

      # ensure application is installed to the prefix in Cellar
      inreplace "settings/cmake_install.cmake" do |s|
        s.gsub!(/\"\/Applications\/KDE\"/, "\"/#{prefix}/Applications/KDE\"")
      end
      system "make", "install", "prefix=#{prefix}"
    end

    resource("sonnet").stage do
      system "cmake", ".", *args
      system "make", "install", "prefix=#{prefix}"
    end

    # install KF5 libraries
    resource("karchive").stage do
      system "cmake", ".", *args
      system "make", "install", "prefix=#{prefix}"
    end

    resource("kcoreaddons").stage do
      system "cmake", ".", *args
      system "make", "install", "prefix=#{prefix}"
    end

    resource("kauth").stage do
      system "cmake", ".", *args
      system "make", "install", "prefix=#{prefix}"
    end

    resource("kcodecs").stage do
      system "cmake", ".", *args
      system "make", "install", "prefix=#{prefix}"
    end

    resource("kconfig").stage do
      system "cmake", ".", *args
      system "make", "install", "prefix=#{prefix}"
    end

    resource("kwidgetsaddons").stage do
      system "cmake", ".", *args
      system "make", "install", "prefix=#{prefix}"
    end

    resource("kcompletion").stage do
      system "cmake", ".", *args
      system "make", "install", "prefix=#{prefix}"
    end

    resource("kguiaddons").stage do
      system "cmake", ".", *args

      # ensure application is installed to the prefix in Cellar
      inreplace "src/geo-scheme-handler/cmake_install.cmake" do |s|
        s.gsub!(/\"\/Applications\/KDE\"/, "\"/#{prefix}/Applications/KDE\"")
      end

      system "make", "install", "prefix=#{prefix}"
    end

    resource("ki18n").stage do
      system "cmake", ".", *args
      system "make", "install", "prefix=#{prefix}"
    end

    resource("kconfigwidgets").stage do
      system "cmake", ".", *args
      system "make", "install", "prefix=#{prefix}"
    end

    resource("kwindowsystem").stage do
      system "cmake", ".", *args
      system "make", "install", "prefix=#{prefix}"
    end

    resource("kcrash").stage do
      system "cmake", ".", *args
      system "make", "install", "prefix=#{prefix}"
    end

    resource("kdbusaddons").stage do
      system "cmake", ".", *args
      system "make", "install", "prefix=#{prefix}"
    end

    resource("kdoctools").stage do
      system "cmake", ".", *args
      system "make", "install", "prefix=#{prefix}"
    end

    resource("kitemviews").stage do
      system "cmake", ".", *args
      system "make", "install", "prefix=#{prefix}"
    end

    resource("kiconthemes").stage do
      system "cmake", ".", *args
      system "make", "install", "prefix=#{prefix}"
    end

    resource("kitemmodels").stage do
      system "cmake", ".", *args
      system "make", "install", "prefix=#{prefix}"
    end

    resource("kmime").stage do
      system "cmake", ".", *args
      system "make", "install", "prefix=#{prefix}"
    end

    resource("knotifications").stage do
      system "cmake", ".", *args
      system "make", "install", "prefix=#{prefix}"
    end

    resource("ktextwidgets").stage do
      system "cmake", ".", *args
      system "make", "install", "prefix=#{prefix}"
    end

    resource("kxmlgui").stage do
      system "cmake", ".", *args
      system "make", "install", "prefix=#{prefix}"
    end
    # end of KF5 libs

    # hide away gpgme++ from kf5, we we need gpgme files include/gpgme++
    chdir "#{prefix}/include/KF5" do
      system "mv", "gpgme++", "gpgme++.not.used"
    end

    resource("libkleo").stage do
      system "cmake", ".", *args
      system "make", "install", "prefix=#{prefix}"
    end

    inreplace "src/dialogs/certificatedetailswidget.cpp" do |s|
      s.gsub!(/ifdef USE_RANGES/, "if 0")
    end

    inreplace "src/view/padwidget.cpp" do |s|
      s.gsub!(/QStringLiteral\(\"Monospace\"\)/, "QFontDatabase::systemFont(QFontDatabase::FixedFont)")
    end

    iconset = create_iconset(buildpath)
    modernize_window
    modernize_ui

    system "cmake", ".", *args

    # ensure application is installed to the prefix in Cellar
    inreplace "src/cmake_install.cmake" do |s|
      s.gsub!(/\"\/Applications\/KDE\"/, "\"/#{prefix}/Applications/KDE\"")
    end

    inreplace "src/kwatchgnupg/cmake_install.cmake" do |s|
      s.gsub!(/\"\/Applications\/KDE\"/, "\"/#{prefix}/Applications/KDE\"")
    end

    system "make", "install"
    install_modern_icon(iconset, prefix/"Applications/KDE/kleopatra.app")

    kleopatra = "#{prefix}/Applications/KDE/kleopatra.app/Contents/MacOS/kleopatra"
    system "install_name_tool", "-add_rpath", "#{prefix}/lib", kleopatra

    # this fixes loading of libdbus in runtime from qt on apple m1
    system "install_name_tool", "-add_rpath", "#{HOMEBREW_PREFIX}/lib", kleopatra
  end

  def create_iconset(directory)
    iconset = directory/"kleopatra.iconset"
    iconset.mkpath
    square = directory/"kleopatra-icon.png"
    system "/usr/bin/sips", "--resampleHeightWidthMax", "1024", Pathname(__dir__)/"images/icon.png", "--out", square
    system "/usr/bin/sips", "--padToHeightWidth", "1024", "1024", square
    [16, 32, 128, 256, 512].each do |size|
      system "/usr/bin/sips", "-z", size.to_s, size.to_s, square, "--out", iconset/"icon_#{size}x#{size}.png"
      system "/usr/bin/sips", "-z", (size * 2).to_s, (size * 2).to_s, square,
             "--out", iconset/"icon_#{size}x#{size}@2x.png"
    end
    iconset
  end

  def install_modern_icon(iconset, bundle)
    resources = bundle/"Contents/Resources"
    resources.mkpath
    system "/usr/bin/iconutil", "-c", "icns", "-o", resources/"kleopatra.icns", iconset
    resources.install iconset.parent/"kleopatra-icon.png" => "kleopatra.png"
    system "/usr/libexec/PlistBuddy", "-c", "Set :CFBundleIconFile kleopatra.icns", bundle/"Contents/Info.plist"
  end

  def modernize_window
    # Objective-C++ uses the Cocoa SDK's enum values and structure-return ABI on
    # both Intel and Apple Silicon, without objc_msgSend casts in Qt's C++ files.
    Pathname("src/macvibrancy.mm").write <<~CPP
      #import <AppKit/AppKit.h>
      #import <objc/runtime.h>
      #include <QtGui/qwindowdefs.h>

      void applyMacVibrancy(WId windowId)
      {
          NSView *view = reinterpret_cast<NSView *>(windowId);
          NSWindow *window = view.window;
          if (!window) {
              return;
          }
          window.opaque = NO;
          window.backgroundColor = NSColor.clearColor;
          static char effectKey;
          if (objc_getAssociatedObject(view, &effectKey)) {
              return;
          }
          NSVisualEffectView *effect = [[NSVisualEffectView alloc] initWithFrame:view.bounds];
          effect.material = NSVisualEffectMaterialUnderWindowBackground;
          effect.blendingMode = NSVisualEffectBlendingModeBehindWindow;
          effect.state = NSVisualEffectStateFollowsWindowActiveState;
          effect.appearance = [NSAppearance appearanceNamed:NSAppearanceNameDarkAqua];
          effect.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
          [view addSubview:effect positioned:NSWindowBelow relativeTo:nil];
          objc_setAssociatedObject(view, &effectKey, effect, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
          [effect release];
      }
    CPP

    inreplace "src/mainwindow.cpp", '#include "mainwindow.h"', <<~CPP.chomp
      #include "mainwindow.h"
      #ifdef Q_OS_MACOS
      void applyMacVibrancy(WId windowId);
      #endif
    CPP
    inreplace "src/mainwindow.cpp", ": KXmlGuiWindow(parent, flags), d(new Private(this))\n{}", <<~CPP.chomp
      : KXmlGuiWindow(parent, flags), d(new Private(this))
      {
      #ifdef Q_OS_MACOS
          setAttribute(Qt::WA_TranslucentBackground, true);
          centralWidget()->setAutoFillBackground(false);
      #endif
      }
    CPP
    inreplace "src/mainwindow.cpp", "    KXmlGuiWindow::showEvent(e);", <<~CPP.chomp
          KXmlGuiWindow::showEvent(e);
      #ifdef Q_OS_MACOS
          applyMacVibrancy(winId());
      #endif
    CPP
    inreplace "src/CMakeLists.txt", "add_executable(kleopatra_bin ${_kleopatra_SRCS} ${_kleopatra_uiserver_SRCS})", <<~CMAKE.chomp
      if (APPLE)
        enable_language(OBJCXX)
        list(APPEND _kleopatra_SRCS macvibrancy.mm)
      endif()
      add_executable(kleopatra_bin ${_kleopatra_SRCS} ${_kleopatra_uiserver_SRCS})
      if (APPLE)
        target_link_libraries(kleopatra_bin "-framework AppKit")
      endif()
    CMAKE
  end

  def modernize_ui
    inreplace "src/main.cpp", "#include <QAccessible>", <<~CPP
      #include <QAccessible>
      #include <QStyleFactory>
      #include <QPalette>
      #include <QColor>
    CPP

    inreplace "src/main.cpp", "KleopatraApplication app(argc, argv);", <<~CPP.chomp
      KleopatraApplication app(argc, argv);
      app.setStyle(QStyleFactory::create(QStringLiteral("Fusion")));

      QPalette breezeDark = app.palette();
      breezeDark.setColor(QPalette::Window, QColor(35, 38, 41));
      breezeDark.setColor(QPalette::WindowText, QColor(239, 240, 241));
      breezeDark.setColor(QPalette::Base, QColor(27, 30, 32));
      breezeDark.setColor(QPalette::AlternateBase, QColor(42, 46, 50));
      breezeDark.setColor(QPalette::ToolTipBase, QColor(35, 38, 41));
      breezeDark.setColor(QPalette::ToolTipText, QColor(239, 240, 241));
      breezeDark.setColor(QPalette::Text, QColor(239, 240, 241));
      breezeDark.setColor(QPalette::Button, QColor(49, 54, 59));
      breezeDark.setColor(QPalette::ButtonText, QColor(239, 240, 241));
      breezeDark.setColor(QPalette::BrightText, QColor(255, 255, 255));
      breezeDark.setColor(QPalette::Link, QColor(61, 174, 233));
      breezeDark.setColor(QPalette::LinkVisited, QColor(155, 89, 182));
      breezeDark.setColor(QPalette::Highlight, QColor(61, 174, 233));
      breezeDark.setColor(QPalette::HighlightedText, QColor(255, 255, 255));
      breezeDark.setColor(QPalette::Light, QColor(71, 77, 83));
      breezeDark.setColor(QPalette::Midlight, QColor(59, 66, 73));
      breezeDark.setColor(QPalette::Mid, QColor(49, 54, 59));
      breezeDark.setColor(QPalette::Dark, QColor(27, 30, 32));
      breezeDark.setColor(QPalette::Shadow, QColor(20, 23, 25));
      breezeDark.setColor(QPalette::Disabled, QPalette::Text, QColor(122, 127, 131));
      breezeDark.setColor(QPalette::Disabled, QPalette::WindowText, QColor(122, 127, 131));
      breezeDark.setColor(QPalette::Disabled, QPalette::ButtonText, QColor(122, 127, 131));
      breezeDark.setColor(QPalette::Disabled, QPalette::Highlight, QColor(70, 75, 80));
      breezeDark.setColor(QPalette::Disabled, QPalette::HighlightedText, QColor(122, 127, 131));
      app.setPalette(breezeDark);

      app.setStyleSheet(QStringLiteral(R"QSS(
          QMainWindow { background-color: rgba(35, 38, 41, 224); }
          QMenuBar {
              background-color: #232629;
              color: #eff0f1;
              border-bottom: 1px solid #3a3f44;
              padding: 2px;
          }
          QMenuBar::item { background: transparent; padding: 4px 8px; border-radius: 4px; }
          QMenuBar::item:selected { background-color: #3daee9; color: #ffffff; }
          QMenuBar::item:disabled { color: #7a7f83; }
          QMenu {
              background-color: #232629;
              color: #eff0f1;
              border: 1px solid #3a3f44;
              border-radius: 6px;
              padding: 4px;
          }
          QMenu::item { padding: 6px 24px 6px 12px; border-radius: 4px; }
          QMenu::item:selected { background-color: #3daee9; color: #ffffff; }
          QMenu::item:disabled { color: #7a7f83; }
          QMenu::separator { height: 1px; background-color: #3a3f44; margin: 4px 8px; }
          QStatusBar { background-color: #232629; color: #a5b0b7; border-top: 1px solid #3a3f44; }
          QToolTip {
              background-color: #232629;
              color: #eff0f1;
              border: 1px solid #3daee9;
              padding: 5px 8px;
              border-radius: 4px;
          }

          QToolBar { background-color: rgba(35, 38, 41, 217); border-bottom: 1px solid #3a3f44; spacing: 6px; padding: 4px; }
          QToolButton { background: transparent; color: #eff0f1; border: 1px solid transparent; border-radius: 5px; padding: 6px 10px; }
          QToolButton:hover { background-color: rgba(61, 174, 233, 46); border-color: #3daee9; }
          QToolButton:pressed, QToolButton:checked { background-color: rgba(61, 174, 233, 89); border-color: #3daee9; }
          QToolButton:disabled { background: transparent; color: #7a7f83; border-color: transparent; }

          QTreeView, QTableView {
              background-color: rgba(27, 30, 32, 209);
              alternate-background-color: rgba(35, 38, 41, 209);
              color: #eff0f1;
              border: 1px solid #3a3f44;
              border-radius: 6px;
              gridline-color: #31363b;
              selection-background-color: #3daee9;
              selection-color: #ffffff;
          }
          QTreeView::item, QTableView::item { padding: 5px; }
          QTreeView::item:hover:!selected, QTableView::item:hover:!selected { background-color: rgba(61, 174, 233, 38); }
          QTreeView::item:selected, QTableView::item:selected { background-color: #2980b9; color: #ffffff; }
          QTreeView:disabled, QTableView:disabled { color: #7a7f83; }

          QHeaderView::section {
              background-color: #232629;
              color: #a5b0b7;
              font-weight: bold;
              padding: 6px 8px;
              border: none;
              border-right: 1px solid #3a3f44;
              border-bottom: 2px solid #3daee9;
          }
          QTableCornerButton::section { background-color: #232629; border: 1px solid #3a3f44; }

          QTabWidget::pane { border: 1px solid #3a3f44; background-color: rgba(35, 38, 41, 230); border-radius: 6px; top: -1px; }
          QTabBar::tab { background-color: #232629; color: #a5b0b7; padding: 8px 18px; border: 1px solid #3a3f44; border-bottom: none; border-top-left-radius: 6px; border-top-right-radius: 6px; margin-right: 2px; }
          QTabBar::tab:selected { background-color: rgba(35, 38, 41, 230); color: #3daee9; border-bottom: 2px solid #3daee9; font-weight: bold; }
          QTabBar::tab:hover:!selected { background-color: #2a2e32; color: #eff0f1; }
          QTabBar::tab:disabled { color: #7a7f83; }

          QPushButton { background-color: #31363b; color: #eff0f1; border: 1px solid #474d53; border-radius: 5px; padding: 6px 18px; }
          QPushButton:hover { background-color: #3b4249; border-color: #3daee9; color: #ffffff; }
          QPushButton:pressed { background-color: #25292c; border-color: #1d74a4; }
          QPushButton:default, QPushButton:focus { border-color: #3daee9; }
          QPushButton:disabled { background-color: #232629; color: #7a7f83; border-color: #31363b; }

          QLineEdit { background-color: #1b1e20; color: #eff0f1; border: 1px solid #474d53; border-radius: 5px; padding: 6px 10px; selection-background-color: #3daee9; selection-color: #ffffff; }
          QLineEdit:focus { border-color: #3daee9; background-color: #232629; }
          QLineEdit:disabled { color: #7a7f83; }

          QTextEdit, QPlainTextEdit { background-color: #1b1e20; color: #eff0f1; border: 1px solid #3a3f44; border-radius: 6px; padding: 8px; selection-background-color: #3daee9; selection-color: #ffffff; }
          QTextEdit:focus, QPlainTextEdit:focus { border-color: #3daee9; }
          QTextEdit:disabled, QPlainTextEdit:disabled { color: #7a7f83; }

          QScrollBar:vertical { background: transparent; width: 10px; margin: 0px; }
          QScrollBar:horizontal { background: transparent; height: 10px; margin: 0px; }
          QScrollBar::handle:vertical { background-color: rgba(255, 255, 255, 56); min-height: 24px; border-radius: 5px; }
          QScrollBar::handle:horizontal { background-color: rgba(255, 255, 255, 56); min-width: 24px; border-radius: 5px; }
          QScrollBar::handle:vertical:hover, QScrollBar::handle:horizontal:hover { background-color: #3daee9; }
          QScrollBar::add-line:vertical, QScrollBar::sub-line:vertical { height: 0px; }
          QScrollBar::add-line:horizontal, QScrollBar::sub-line:horizontal { width: 0px; }
          QScrollBar::add-page:vertical, QScrollBar::sub-page:vertical, QScrollBar::add-page:horizontal, QScrollBar::sub-page:horizontal { background: transparent; }
      )QSS"));
    CPP
  end

  test do
    k = "#{prefix}/Applications/KDE/kleopatra.app/Contents/MacOS/kleopatra"
    system k, "--help"
  end

  def caveats
    <<~EOS
      After Installing:

      Make sure dbus is running
        brew services start dbus

      Select pinentry-mac as the default program
        brew install pinentry-mac
        echo "pinentry-program #{HOMEBREW_PREFIX}/bin/pinentry-mac" > ~/.gnupg/gpg-agent.conf
        killall -9 gpg-agent

      There is a clean PATH method below to run 'kleopatra',
      but it is also ok to create a quick symlink using
        ln -s #{opt_prefix}/bin/kleopatra #{HOMEBREW_PREFIX}/bin/

      If you want to add this application to the Launchpad
        cd /Applications && unzip #{opt_prefix}/app.zip

    EOS
  end

  def post_install
    zip = "#{opt_prefix}/zip/kleopatra.app"
    src = "#{opt_prefix}/Applications/KDE/kleopatra.app"

    chdir src do
      system "sh", "-c", "find . | while read a; do if [ -d $a ]; then
        mkdir -p #{zip}/$a; else cp #{src}/$a #{zip}/$a; fi; done"
    end

    system "chmod", "+w", "#{zip}/Contents/MacOS/kleopatra"
    File.write "#{zip}/Contents/MacOS/kleopatra", <<~EOS
      #!/bin/sh
      PATH=#{HOMEBREW_PREFIX}/bin:$PATH exec #{src}/Contents/MacOS/kleopatra
    EOS

    chdir "#{opt_prefix}/zip" do
      system "zip", "-r", "#{opt_prefix}/app.zip", "."
    end

    system "ln", "-sf", "#{src}/Contents/MacOS/kleopatra",
      "#{opt_prefix}/bin/kleopatra"
  end
end
