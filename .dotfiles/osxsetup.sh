#/bin/bash -xe

# Script to setup a new macOS system. 
# 	Author: Kevin Pickard
#		Date: 10/13/16
#			This script will install requirements for a macOS system (Tested on 10.12)
#			Installs Xcode CLI Tools, Homebrew, Fish, and vim. 

## Install Xcode CLI Tools ##
echo "Parsing Xcode CLI install command..."
touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
PROD=$(softwareupdate -l |
  grep "\*.*Command Line" |
	head -n 1 | awk -F"*" '{print $2}' |
	sed -e 's/^ *//' |
	tr -d '\n')
softwareupdate -i "$PROD" --verbose;

## Install Homebrew ##
echo "Installing Homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
#		Update
brew update

## Clone github .dotfiles repo
echo "Pulling down system configuration files..."
git clone --bare https://github.com/kevinjpickard/.dotfiles.git $HOME/.dotfiles
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

## Install Powerline ##
#	Install Powerline
pip install powerline-status
#	Install powerline fonts
mkdir ~/scratch/fonts
git clone https://github.com/powerline/fonts.git ~/scratch/fonts
~/scratch/fonts/install.sh

## Install oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh

## ZSH Syntax Highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

## ZSH Completion Suggestions 
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

## Install Vundle ##
echo "Installing Vundle..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
#	Initialize and install plugins
echo "Initializing vim plugins..."
vim +PluginInstall +qall
# Make swap, backup, etc directories, set permissions
mkdir -p ~/backups/vim{backups,swap,undo}
chmod -R 766 ~/backups

## Install Color Schemes ##
#	Create scratch directory
#mkdir scratch
#	Clone git repo
#echo "Downloading iTerm2 color schemes..."
#git clone https://github.com/mbadolato/iTerm2-Color-Schemes.git ~/scratch/

## Set shell to ZSH ##
echo "Setting default user shell to ZSH..."
#		Need to add ZSH to /etc/shells
echo "/usr/local/bin/zsh" | sudo tee -a /etc/shells
#		Now set shell to zsh
chsh -s '/usr/local/bin/zsh'

## Install vagrant plugins
vagrant plugin install vagrant-saltdeps vagrant-scp vagrant-serverspec vagrant-share vagrant-vmware-fusion vagrant-winrm

# Install NVM
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash

## Set various OSX Settings. ##
echo "Tweaking some shit so its juuuuuuuuuust the way I like it..."
chmod +x ~/.dotfiles/osx_settings.sh
sudo ~/.dotfiles/osx_settings.sh

## Dark menu bar and dock ##
echo "Dark Theme?"
defaults write /Library/Preferences/.GlobalPreferences AppleInterfaceTheme Dark

## Finished ##
echo "Configuration complete!"
