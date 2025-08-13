#!/bin/bash

echo " hi"
echo "root permissions are required for a few commands, asking upfront"
sudo -v

# Keep-alive: update existing `sudo` time stamp until this script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# exit if anything fails
set -e

# Set Terminal Preferences
touch ~/.zshrc
echo "alias python='python3'" >> ~/.zshrc
echo "alias pip='pip3'" >> ~/.zshrc
echo "PROMPT='%m : '" >> ~/.zshrc
echo "export CLICOLOR=1" >> ~/.zshrc
echo "export PATH=\"/opt/homebrew/bin:$PATH\"" >> ~/.zshrc

# Check if Command Line Tools are installed
if ! xcode-select -p &>/dev/null; then
  echo "Command Line Tools not found. Installing..."

  # This command triggers the software update prompt for CLT
  xcode-select --install

  # Wait until the installation is done
  echo "Waiting for Command Line Tools installation to complete..."
  until xcode-select -p &>/dev/null; do
    sleep 5
  done

  echo "Command Line Tools installed successfully."
else
  echo "Command Line Tools already installed."
fi

name="codex" 
echo "Set computer name to $name"; {
  [[ "$(scutil --get ComputerName)" == "$name" ]] || sudo scutil --set ComputerName "$name"
  [[ "$(scutil --get LocalHostName)" == "$name" ]] || sudo scutil --set LocalHostName "$name"
}

echo "Enable tap to click"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1

# -- Doc customization --
# remove default apps from the doc
defaults write com.apple.dock persistent-apps -array ""

# automatically show/hide doc
defaults write com.apple.dock autohide -bool true

# make the dock as small as possible
defaults write com.apple.dock tilesize -int 16
# defaults write com.apple.dock tilesize -int 64

# Show Finder Pathbar
defaults write com.apple.finder ShowPathbar -bool true

# Show all filename extensions in Finder
#defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Save screenshots to a seperate folder and dont show thumbnail
mkdir -p "$HOME/Pictures/Screenshots"
defaults write com.apple.screencapture "location" -string "$HOME/Pictures/Screenshots"
defaults write com.apple.screencapture "show-thumbnail" -bool "false"

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Beep feedback when changing volume
defaults write NSGlobalDomain com.apple.sound.beep.feedback -integer 1

# Disable “natural” (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

sleep 1

# Restart applications
for app in Finder Dock SystemUIServer cfprefsd; do killall "$app" > /dev/null 2>&1; done
echo "Done.  Tap to click, and scroll to zoom require a restart"
