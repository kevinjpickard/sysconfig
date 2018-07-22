#/bin/bash -ex

echo 'Detected Arch linux'

## Set Locale, Language, Time Zone, Hostname, etc.
timedatectl set-ntp true
sudo rm /etc/localtime
sudo ln -sf /usr/share/zoneinfo/America/Denver /etc/localtime
hwclock --systohc
sed -i '/en-US.utf-8 UTF-8/s/^#//g' /etc/locale.gen
sudo locale-gen
echo "LANGUAGE=en_US
LANG=en_US.UTF-8
LC_ALL=C" | sudo tee -a /etc/locale.conf

## Install Yaourt
echo 'Installing Yay'
mkdir -p ~/Documents/github.com/scratch
git clone https://aur.archlinux.org/yay.git ~/Documents/github.com/scratch/yay
$(cd ~/Documents/github.com/scratch/yay; makepkg --noconfirm -si)

## Install Apps
echo 'Installing apps'
# Glances
#curl -L https://bit.ly/glances | /bin/bash
# Keys
gpg --recv-keys 8F0871F202119294
gpg --recv-keys 702353E0F7E48EDB

# All non-AUR Apps
echo 'Installing Apps...'
sudo pacman --needed --noconfirm -Sy - < ~/.dotfiles/arch_packages

## AUR packages are a bit more difficult
#	These are a bit more difficult. Read them into an array
echo 'Installing AUR packages...'
packages=$(<~/.dotfiles/arch_packages_aur)
# Now iterate and install
for package in $packages; do
  yay -Sy --devel --aur --noconfirm $package
done

## Enable Services
# Same play as above
services=$(<~/.dotfiles/arch_enabled_services)
for service in $services; do
	systemctl enable $service
done

## Setting up ZSH
# Clone oh-my-zsh
echo 'Setting up zsh'
git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
# Syntax Highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# ZSH Autosuggestions
git clone git://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# Change Shell
chsh -s `which zsh`

## Install dein
echo "Installing dein..."
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ~/installer.sh
sh ./installer.sh ~/.config/nvim/dein
echo "Setting up folder structure..."
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config/nvim}
ln -s ~/.config/nvim ~/.vim
ln -s $XDG_CONFIG_HOME/nvim/init.vim ~/.vimrc
echo "Setting up neovim..."
# molokai color scheme
mkdir ~/.vim/colors
curl https://raw.githubusercontent.com/tamelion/neovim-molokai/master/colors/molokai.vim -o ~/.vim/colors/molokai.vim

