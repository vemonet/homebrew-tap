cask "typodown" do
  arch arm: "arm64", intel: "x64"

  version "0.0.5"
  sha256 arm:   "403391ab1912697812cdeae7f7e49a8b7eb40dd8301e733281b965a1fd220454",
         intel: "cc653961a559ff5b925b6b209621affaa3aa2320b521a01b1d557b63542f6f48"

  url "https://github.com/vemonet/typodown/releases/download/v#{version}/Typodown-macos-#{arch}.dmg"
  name "Typodown"
  desc "Open source and cross-platform markdown editor inspired by Typora"
  homepage "https://typodown.app/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "Typodown.app"

  # The app is signed ad-hoc, not with an Apple Developer ID, so Gatekeeper refuses to launch it
  # while the download still carries the quarantine flag. Dropping the flag on this app only skips
  # that check; without it the user has to right-click > Open, or approve it in System Settings.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Typodown.app"]
  end

  uninstall quit: "io.github.vemonet.typodown"

  zap trash: [
    "~/Library/Application Support/io.github.vemonet.typodown",
    "~/Library/Caches/io.github.vemonet.typodown",
    "~/Library/HTTPStorages/io.github.vemonet.typodown",
    "~/Library/Preferences/io.github.vemonet.typodown.plist",
    "~/Library/Saved Application State/io.github.vemonet.typodown.savedState",
    "~/Library/WebKit/io.github.vemonet.typodown",
  ]
end
