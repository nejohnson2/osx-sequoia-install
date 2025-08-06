
# remove default apps from the doc
defaults write com.apple.dock persistent-apps -array ""

# automatically show/hide doc
defaults write com.apple.dock autohide -bool true

# make the dock as small as possible
defaults write com.apple.dock tilesize -int 1
# defaults write com.apple.dock tilesize -int 64
