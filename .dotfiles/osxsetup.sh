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

## Step 3: Install Fish ##
echo "Installing Fish"
brew install fish

## Step 4: Install vim ##
echo "Installing vim..."
brew install vim

## Step 5: Clone github .dotfiles repo
echo "Pulling down system configuration files..."
git clone --bare https://github.com/kevinjpickard/.dotfiles $HOME/.dotfiles
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME fetch
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout osx
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME pull origin osx
echo ".dotfiles" >> .gitignore
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

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

## Finished ##
echo "Configuration complete!"

