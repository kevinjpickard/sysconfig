# Linux Boostrapper
## Update and Upgrade ##
sudo apt-get update -y
sudo apt-get upgrade -y
#sudo apt dist-upgrade -y
sudo apt-get autoremove -y

## Repositories
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

## Update New Repos
sudo apt-get update

## Apps
sudo curl https://raw.githubusercontent.com/kevinjpickard/.dotfiles/apt/.dotfiles/apps.conf -o ~/apps.conf 
sudo apt-get install -y $(grep -vE "^\s*#" apps.conf | tr "\n" " ")

## Powerline
#	Scratch directory
mkdir ~/Documents/github
mkdir ~/Documents/github/scratch
sudo apt-get install python-pip
pip install --upgrade pip
pip install powerline-status
pip install git+git://github.com/powerline/powerline
mkdir ~/Documents/github/scratch/powerline-shell
git clone https://github.com/milkbikis/powerline-shell ~/scratch/powerline-shell
cp ~/Documents/github/scratch/powerline-shell/config.py.dist ~/scratch/powerline-shell/config.py
cd ~/Documents/github/scratch/powerline-shell
chmod +r segments/
chmod +r segments/*
./install.py
cd ~
#	Install powerline fonts
mkdir ~/scratch/fonts
git clone https://github.com/powerline/fonts.git ~/Documents/github/scratch/fonts
~/Documents/github/scratch/fonts/install.sh
cd ~

## Install Keybase
curl -O https://prerelease.keybase.io/keybase_amd64.deb
sudo dpkg -i keybase_amd64.deb
sudo apt-get install -f
#run_keybase

## Step 3: Clone github .dotfiles repo
echo "Pulling down system configuration files..."
rm ~/.bashrc
git clone --bare https://github.com/kevinjpickard/.dotfiles.git $HOME/.dotfiles
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME fetch
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout osx
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME pull origin osx
echo ".dotfiles" >> .gitignore
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

## Step 7: Install Vundle ##
echo "Installing Vundle..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
#	Initialize and install plugins
echo "Initializing vim plugins..."
vim +PluginInstall +qall

## Step 10: Install vagrant plugins
vagrant plugin install vagrant-saltdeps vagrant-scp vagrant-serverspec vagrant-share vagrant-vmware-fusion vagrant-winrm

## Settings
#   GNOME DE Extensions + Configs, if running
sudo -Hiu kevin ~/.dotfiles/gnome_settings.sh

## Aliases
echo "alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" | sudo tee -a ~/.bash_profile
