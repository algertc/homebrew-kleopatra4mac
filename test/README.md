# UI modernization verification

The focused suite patches the exact Kleopatra v22.07.80 source used by the
formula, compiles the injected code against Qt 5, and exercises Cocoa window
lifecycle behavior and macOS icon packaging. Run on macOS with `qt@5` installed.

Download and extract the source URL declared in `kleopatra.rb`, verifying its
SHA-256 against the formula, then pass the extracted directory to the suite:

```sh
/opt/homebrew/bin/brew ruby -- test/ui_modernization.rb /absolute/path/to/kleopatra-22.07.80
```

Use your Homebrew installation's `bin/brew` path on Intel Macs.

The suite checks Fusion and Breeze colors, window alpha, QSS parsing and widget
rendering, scrollbars, a relocated bundle's application and dialog icons,
Cocoa material selection, duplicate effect prevention and resizing, all ten
standard/Retina icon sizes, ICNS installation, the bundle plist, and patch
anchors that must fail explicitly when the upstream source changes.

For installation coverage, build the complete formula and run its smoke test:

```sh
brew install --build-from-source kayyo321/kleopatra4mac/kleopatra
brew test kayyo321/kleopatra4mac/kleopatra
```

The GPGME resource's upstream regression fixture setup is disabled during
installation because it needs a GPG agent inside the build sandbox. App runtime
and cryptographic checks should use a separate temporary `GNUPGHOME`.
