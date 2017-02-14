#/bin/bash -xe

# Script to setup a new macOS system. 
# 	Author: Kevin Pickard
#		Date: 10/13/16
#			This script will install requirements for a macOS system (Tested on 10.12)
#			Installs Xcode CLI Tools, Homebrew, Fish, and vim. 

## Step 1: Install Xcode CLI Tools ##
echo "Parsing Xcode CLI install command..."
touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
PROD=$(softwareupdate -l |
  grep "\*.*Command Line" |
	head -n 1 | awk -F"*" '{print $2}' |
	sed -e 's/^ *//' |
	tr -d '\n')
softwareupdate -i "$PROD" --verbose;

## Step 2: Install Homebrew ##
echo "Installing Homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
#		Update
brew update

## Step 3: Clone github .dotfiles repo
echo "Pulling down system configuration files..."
git clone --bare git@github.com:kevinjpickard/.dotfiles.git $HOME/.dotfiles
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME fetch
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout osx
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME pull origin osx
echo ".dotfiles" >> .gitignore
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

## Step 4: Install a lot of shit ##
echo "Installing a lot of shit..."
brew cask install java
brew tap homebrew/bundle
brew bundle --file=~/.dotfiles/Brewfile

## Step 6: Install Powerline ##
#		Install python
brew install python
#		Install Powerline
pip install powerline-status
pip install git+git://github.com/powerline/powerline
mkdir ~/scratch/powerline-shell
git clone https://github.com/milkbikis/powerline-shell ~/scratch/powerline-shell
cp ~/scratch/powerline-shell/config.py.dist ~/scratch/powerline-shell/config.py
cd ~/scratch/powerline-shell
chmod +r segments/
chmod +r segments/*
./install.py
cd ~
#		Install powerline fonts
mkdir ~/scratch/fonts
git clone https://github.com/powerline/fonts.git ~/scratch/fonts
~/scratch/fonts/install.sh

## Step 7: Install Vundle ##
echo "Installing Vundle..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
#		Initialize and install plugins
echo "Initializing vim plugins..."
vim +PluginInstall +qall

## Step 8: Install Color Schemes ##
#		Create scratch directory
mkdir scratch
#		Clone git repo
echo "Downloading iTerm2 color schemes..."
git clone https://github.com/mbadolato/iTerm2-Color-Schemes.git ~/scratch/

## Step 9: Set shell to fish ##
echo "Setting default user shell to Fish..."
#		First we must add fish to /etc/shells
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
#		Now set shell to fish
chsh -s '/usr/local/bin/fish'

## Step 10: Install vagrant plugins
vagrant plugin install vagrant-saltdeps vagrant-scp vagrant-serverspec vagrant-share vagrant-vmware-fusion vagrant-winrm

## Step 11: Set various OSX Settings. ##
echo "Tweaking some shit so its juuuuuuuuuust the way I like it..."
chmod +x ~/.dotfiles/osx_settings.sh
sudo ~/.dotfiles/osx_settings.sh

## Step 12: Dark menu bar and dock ##
echo "Dark Theme?"
defaults write /Library/Preferences/.GlobalPreferences AppleInterfaceTheme Dark

## Finished ##
echo "Configuration complete!"

