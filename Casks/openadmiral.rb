cask "openadmiral" do
  version "0.1.4"
  sha256 "5ecd1c1e6cdc943abb5ef4b90458b9e5b70eaab0eabab3a16c64b619ff5d0ff6"

  url "https://openadmiral.com/downloads/#{version}/OpenAdmiral_#{version}_universal.dmg"
  name "OpenAdmiral"
  desc "Mission control for Claude Code sessions"
  homepage "https://openadmiral.com/"

  livecheck do
    url "https://openadmiral.com/updates/latest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  auto_updates true
  depends_on macos: :ventura

  app "OpenAdmiral.app"

  # Underway's helper (a launchd daemon the app registers once you allow it).
  uninstall quit:      "com.openadmiral.desktop",
            launchctl: "com.openadmiral.helper"

  zap trash: [
    "~/Library/Application Support/com.openadmiral.desktop",
    "~/Library/Caches/com.openadmiral.desktop",
    "~/Library/Logs/OpenAdmiral",
    "~/Library/WebKit/com.openadmiral.desktop",
  ]

  caveats <<~EOS
    OpenAdmiral shows the Claude Code sessions that run its plugin. Add it in any
    Claude Code session:
      /plugin marketplace add OpenAdmiral/openadmiral
      /plugin install openadmiral@openadmiral
  EOS
end
