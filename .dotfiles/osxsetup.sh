#/bin/bash -x

# Script to setup a new macOS system. 
# 	Author: Kevin Pickard
#		Date: 10/13/16
#			This script will install requirements for a macOS system (Tested on 10.12)
#			Installs Xcode CLI Tools, Homebrew, Fish, and vim. 

## Step 1: Install Xcode CLI Tools ##
touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
PROD=$(softwareupdate -l |
  grep "\*.*Command Line" |
	head -n 1 | awk -F"*" '{print $2}' |
	sed -e 's/^ *//' |
	tr -d '\n')
softwareupdate -i "$PROD" --verbose;

## Step 2: Install Homebrew ##
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
#		Update
brew update

## Step 3: Install Fish ##
brew install fish

## Step 4: Install vim ##
brew install vim

## Step 5: Clone github .dotfiles repo
git clone --bare kevinjpickard/.dotfiles $HOME/.cfg
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dots fetch
dots checkout osx
echo ".dotfiles" >> .gitignore
dots config --local status.showUntrackedFiles no

## Step 6: Install Vundle ##
git clone https://github.com/VundleVim/Vundle/vim.git ~/.vim/bundle/Vundle.vim
#		Initialize and install plugins
vim +PluginInstall +qall
