#!/bin/bash

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add homebrew to path
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew install git
brew install python

brew install --cask google-chrome
brew install --cask lastpass
brew install --cask chatgpt
brew install --cask visual-studio-code

# Configure Github
git config --global user.name "Nicholas Johnson"
git config --global user.email "nejohnson2@gmail.com"

# do this manually
#ssh-keygen -t ed25519 -C "nejohnson2@gmail.com"
#eval "$(ssh-agent -s)"
#ssh-add --apple-use-keychain ~/.ssh/id_ed25519
# copy your key to github
# pbcopy < ~/.ssh/id_ed25519.pub
# Test connection
# ssh -T git@github.com
