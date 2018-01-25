echo 'Detected Arch linux, redirecting...'
## Set Locale, Language, Time Zone, Hostname, etc.
timedatectl set-ntp true
rm /etc/localtime
ln -sf /usr/share/zoneinfo/America/Denver /etc/localtime
hwclock --systohc
sed -i '/en-US.utf-8 UTF-8/s/^#//g' /etc/locale.gen
locale-gen
echo "LANGUAGE=en_US
LANG=en_US.UTF-8
LC_ALL=C" > /etc/locale.conf
echo 'Hostname?'
read INPUT
echo $INPUT > /etc/hostname

## Install Yaourt
mkdir -p ~/Documents/github.com/scratch
git clone https://aur.archlinux.org/package-query.git ~/Documents/github.com/scratch/package-query
git clone https://aur.archlinux.org/yaourt.git ~/Documents/github.com/scratch/yaourt
$(cd ~/Documents/github.com/scratch/package-query; makepkg -si)
$(cd ~/Documents/github.com/scratch/yaourt; makepkg -si)

## Install Apps
# Glances
#curl -L https://bit.ly/glances | /bin/bash

# All non-AUR Apps
yaourt --needed -S - < ~/.dotfiles/arch_packages

## AUR packages are a bit more difficult
#	These are a bit more difficult. Read them into an array
packages=$(<~/.dotfiles/arch_packages_aur)
# Now iterate and install
for package in $packages; do
  yaourt -Sy --devel --aur --noconfirm $package
done

## Enable Services
# Same play as above
services=$(<~/.dotfiles/arch_enabled_services)
for service in $services; do
	systemctl enable $service
done
