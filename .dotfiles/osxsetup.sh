#/bin/bash -xe

# Script to setup a new macOS system. 
# 	Author: Kevin Pickard
#		Date: 10/13/16
#			This script will install requirements for a macOS system (Tested on 10.12)
#			Installs Xcode CLI Tools, Homebrew, Fish, and vim. 

## Install a lot of shit
echo "Installing a lot of shit..."
brew cask install java
brew tap homebrew/bundle
brew bundle --file=~/.dotfiles/Brewfile
curl https://bootstrap.pypa.io/get-pip.py | bash

## Install Powerline
#	Install Powerline
pip install powerline-status
pip3 install powerline-status
#	Install powerline fonts
mkdir ~/scratch/fonts
git clone https://github.com/powerline/fonts.git ~/scratch/fonts
~/scratch/fonts/install.sh

## Install oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh

## ZSH Syntax Highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

## ZSH Completion Suggestions 
git clone git://github.com/zsh-users/zsh-autosuggestions ${zsh_custom:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

## Install dein
echo "Installing dein..."
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -s ~/.vim $XDG_CONFIG_HOME/nvim
ln -s ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ~/installer.sh
sh ./installer.sh ~/.config/nvim/dein

#	Initialize and install plugins
echo "Initializing vim/nvim plugins..."
mkdir -p ~/.vim/colors
curl https://raw.githubusercontent.com/tamelion/neovim-molokai/master/colors/molokai.vim -o ~/.vim/colors/molokai.vim

# Make swap, backup, etc directories, set permissions
mkdir -p ~/backups/vim{backups,swap,undo}
chmod -R 766 ~/backups

## Set shell to ZSH
echo "Setting default user shell to ZSH..."
#		Need to add ZSH to /etc/shells
echo "/usr/local/bin/zsh" | sudo tee -a /etc/shells
#		Now set shell to zsh
chsh -s '/usr/local/bin/zsh'
#   Now switch to ZSH, switch to VIM bindings
zsh
bindkey -v

## Install vagrant plugins
vagrant plugin install vagrant-saltdeps vagrant-scp vagrant-serverspec vagrant-share vagrant-vmware-fusion vagrant-winrm

# Install NVM
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash

## Set various OSX Settings.
echo "Tweaking some shit so its juuuuuuuuuust the way I like it..."
chmod +x ~/.dotfiles/osx_settings.sh
sudo ~/.dotfiles/osx_settings.sh

## Hammerspoon Addons
#   hs.tiling
mkdir -p $HOME/.hammerspoon/hs
git clone https://github.com/dsanson/hs.tiling $HOME/.hammerspoon/hs/tiling

## macOS Settings
echo "Dark Theme?"
sudo defaults write /Library/Preferences/.GlobalPreferences.plist AppleInterfaceTheme Dark
defaults write com.apple.finder AppleShowAllFiles YES
defaults write com.apple.mouse scaling -1
# Enabling the 'Anywhere' option in Gatekeeper
sudo spctl --master-disable

## Finished
echo "Configuration complete!"
