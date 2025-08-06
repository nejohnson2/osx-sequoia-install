echo " hi"
echo "root permissions are required for a few commands, asking upfront"
sudo -v
# Keep-alive: update existing `sudo` time stamp until this script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# exit if anything fails
set -e

name="codex" 
echo "Set computer name to $name"; {
  [[ "$(scutil --get ComputerName)" == "$name" ]] || scutil --set ComputerName $name
  [[ "$(scutil --get LocalHostName)" == "$name" ]] || scutil --set LocalHostName $name
}

echo "Enable tap to click"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1

# remove default apps from the doc
defaults write com.apple.dock persistent-apps -array ""

# automatically show/hide doc
defaults write com.apple.dock autohide -bool true

# make the dock as small as possible
defaults write com.apple.dock tilesize -int 1
# defaults write com.apple.dock tilesize -int 64

# Allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

for app in Finder Dock SystemUIServer cfprefsd; do killall "$app" > /dev/null 2>&1; done
echo "Done.  Tap to click, and scroll to zoom require a restart"
