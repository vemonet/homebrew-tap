cask "alt-tab-pro" do
  version "11.7.0"
  sha256 "878d297ea10f530d04c63ba98cd8a90da6bd70d20aeb7bf3b85c3195b678f626"

  url "https://github.com/vemonet/alt-tab-macos-free/releases/download/v#{version}/AltTab-Pro.zip"
  name "AltTab Pro"
  desc "Alt-tab switcher with Pro features enabled"
  homepage "https://github.com/vemonet/alt-tab-macos-free"

  livecheck do
    url :url
    strategy :github_latest
  end

  conflicts_with cask: "alt-tab"
  depends_on macos: :monterey

  app "AltTab.app"

  # The release is signed with a throwaway self-signed cert, so Gatekeeper refuses to launch it
  # while the download carries the quarantine flag. Dropping the flag on this app only skips that
  # check; without it the user has to approve the app in System Settings after every install.
  # The three defaults keep Sparkle auto-update asleep
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/AltTab.app"]
    run "/usr/bin/defaults",
        args:           ["write", "com.lwouis.alt-tab-macos", "SUEnableAutomaticChecks", "-bool", "false"],
        writable_paths: ["~/Library/Preferences/com.lwouis.alt-tab-macos.plist"]
    run "/usr/bin/defaults",
        args:           ["write", "com.lwouis.alt-tab-macos", "SUAutomaticallyUpdate", "-bool", "false"],
        writable_paths: ["~/Library/Preferences/com.lwouis.alt-tab-macos.plist"]
    run "/usr/bin/defaults",
        args:           ["write", "com.lwouis.alt-tab-macos", "updatePolicy", "-string", "0"],
        writable_paths: ["~/Library/Preferences/com.lwouis.alt-tab-macos.plist"]
  end

  uninstall quit: "com.lwouis.alt-tab-macos"

  zap trash: [
    "~/Library/Caches/com.lwouis.alt-tab-macos",
    "~/Library/HTTPStorages/com.lwouis.alt-tab-macos",
    "~/Library/Preferences/com.lwouis.alt-tab-macos.plist",
    "~/Library/Saved Application State/com.lwouis.alt-tab-macos.savedState",
  ]

  caveats <<~EOS
    Each release is signed with a different self-signed certificate, so macOS asks for
    Accessibility and Screen Recording permissions again after an upgrade.

    Sparkle's automatic checks are turned off at install, so `brew upgrade` is what moves you
    to a newer release. "Check for updates now…" in the app still reaches upstream's appcast,
    and installing what it offers replaces this build with the official one.
  EOS
end
