#!/bin/bash

theme="Woom"

echo "checking system requirement..."
if [[ $OSTYPE != "darwin"* ]]; then
  echo "Failed to run the script due to system incompatibility."
  exit 1 
fi

echo "checking homebrew..."
if [[ $(command -v brew) == "" ]]; then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Updating homebrew..."
  brew update
fi
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "installing git, vim and zsh ..."
brew install git
brew install vim
brew install zsh

echo "installing nerd-fonts ..."
brew tap homebrew/cask-fonts
brew install font-hack-nerd-font

#TODO: store .zshrc on github
echo "installing spaceship..."
brew install spaceship
echo "source $(brew --prefix)/opt/spaceship/spaceship.zsh" >> ~/.zshrc

# install libplist to use plutil to control terminal theme
echo "installing libplist..."
brew install libplist

echo "installing $theme theme..."
plutil -insert "Window Settings.$theme" -xml "$(curl -s https://raw.githubusercontent.com/jaecs/woom/main/themes/$theme.terminal)" ~/Library/Preferences/com.apple.Terminal.plist

echo "setting $theme as default theme..."
defaults write com.apple.Terminal "Default Window Settings" -string "$theme"
defaults write com.apple.Terminal "Startup Window Settings" -string "$theme"

echo "Your all set. Congratulation!"
echo "Please close and reopen your terminal. Enjoy!"
