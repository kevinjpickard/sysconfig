# Linux Boostrapper
## Update and Upgrade ##
sudo apt-get update -y
sudo apt-get upgrade -y
#sudo apt dist-upgrade -y
sudo apt-get autoremove -y

## Repositories
# Some dependencies, probably already installed
sudo apt-get install -y \
    apt-transport-https ca-certificates curl software-properties-common \
    linux-image-extra-$(uname -r) linux-image-extra-virtual
#	Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
#	Spotify
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
#	Sublime
sudo add-apt-repository -y ppa:webupd8team/sublime-text-3
#	Veracrypt
sudo add-apt-repository -y ppa:unit193/encryption
# Kodi
sudo add-apt-repository -y ppa:team-xbmc/ppa
# Docker
## Just in case, removing old ones
sudo apt-get remove docker docker-engine
## Adding updated Docker repo
curl -fsSL https://apt.dockerproject.org/gpg | sudo apt-key add -
apt-key fingerprint 58118E89F3A912897C070ADBF76221572C52609D
#sudo add-apt-repository -y "deb https://apt.dockerproject.org/repo/ ubuntu-$(lsb_release -cs) main"
#   Hard-coding xenial repos since zesty isn't supported yet
sudo add-apt-repository -y "deb https://apt.dockerproject.org/repo/ ubuntu-xenial main"

## Update New Repos
sudo apt-get update

## Apps
sudo apt-get install -y $(grep -vE "^\s*#" ~/.dotfiles/apps.conf | tr "\n" " ")

### Install vagrant from vagrant website, debian packaging bugged
curl https://releases.hashicorp.com/vagrant/1.9.5/vagrant_1.9.5_x86_64.deb -o ~/vagrant_installer.deb
sudo dpkg -i ~/vagrant_installer.deb
rm ~/vagrant_installer.deb

## Powerline
#	Scratch directory
mkdir ~/Documents/github
mkdir ~/Documents/github/scratch
pip install --upgrade pip
sudo -H pip install powerline-status
#	Install powerline fonts
mkdir ~/scratch/fonts
sudo git clone https://github.com/powerline/fonts.git /home/kevin/Documents/github/scratch/fonts
sudo /home/kevin/Documents/github/scratch/fonts/install.sh

## Install oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh

## ZSH Syntax Highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# ZSH Autosuggestions
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

## Install Keybase
curl -O https://prerelease.keybase.io/keybase_amd64.deb
sudo dpkg -i keybase_amd64.deb
sudo apt-get install -f
#run_keybase

## Monokai color scheme for Gnome Terminal
git clone git://github.com/pricco/gnome-terminal-colors-monokai.git $HOME/Documents/github/scratch
$HOME/Documents/github/scratch/gnome-terminal-colors-monokai/install.sh

## Install Vundle ##
echo "Installing dein..."
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ~/installer.sh
sh ./installer.sh ~/.config/nvim/dein
#	Initialize and install plugins
echo "Initializing vim/nvim plugins..."
vim +call dein#install()

## Install vagrant plugins
vagrant plugin install vagrant-saltdeps vagrant-scp vagrant-serverspec vagrant-share vagrant-winrm

# Install NVM
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash

# Setup rbenv cuz its different on Ubuntu
git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
exec $SHELL
rbenv install 2.2.3
rbenv global 2.2.3
rbenv rehash

## Settings
#   GNOME DE Extensions + Configs, if running
~/.dotfiles/gnome_settings.sh
#		Start docker at boot
sudo systemctl enable docker
#		Manage docker sans sudo
sudo groupadd docker
sudo usermod -aG docker $USER

## Changing shells
chsh -s `which zsh`

## Changing origin
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME remote set-url origin git@github.com:kevinjpickard/.dotfiles.git

# Done
echo "Configuration finished! Please reboot, then run 'sudo sensors-detect'"
