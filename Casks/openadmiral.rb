cask "openadmiral" do
  version "0.1.7"
  sha256 "a101889c1614e32c9ff4c157d4351af7aa4efe6eac6f24901519a31478a25f4c"

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
