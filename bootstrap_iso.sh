#!/bin/bash
# encoding: utf-8

# Most of this comes from: https://gist.github.com/magnunleno/3641682

##################################################
#       Variables        #
##################################################
# Computer Name
HOSTN=KJP-Test

# Username
USERNAME=kevin

# Keyboard Layout
KEYBOARD_LAYOUT=en_US.

# Your language, used for localization purposes
LANGUAGE=en_US

# Geography Localization. Verify the directory /usr/share/zoneinfo/<Zone>/<SubZone>
LOCALE=America/Denver

# Root password for the brand new installed system
ROOT_PASSWD=123456

########## Hard Disk Partitioning Variable
# ANTENTION, this script erases ALL YOU HD DATA (specified bt $HD)
HD=/dev/sda
# Boot Partition Size: /boot
BOOT_SIZE=1024
# Root Partition Size: /
ROOT_SIZE=10000
# Swap partition size: /swap
SWAP_SIZE=$(($(grep MemTotal /proc/meminfo | awk '{print $2}')/1000))
echo "Swap: $SWAP_SIZE"
# The /home partition will occupy the remain free space

# Partitions file system
BOOT_FS=ext4
HOME_FS=ext4
ROOT_FS=ext4

# Extra packages (not obligatory)
EXTRA_PKGS='neovim git ansible'


######## Auxiliary variables. THIS SHOULD NOT BE ALTERED
BOOT_START=1
BOOT_END=$(($BOOT_START+$BOOT_SIZE))

SWAP_START=$BOOT_END
SWAP_END=$(($SWAP_START+$SWAP_SIZE))

ROOT_START=$SWAP_END
ROOT_END=$(($ROOT_START+$ROOT_SIZE))

HOME_START=$ROOT_END

##################################################
#       Script       #
##################################################
# Loads the keyboard layout
loadkeys $KEYBOARD_LAYOUT

#### Partitioning
echo "HD Initialization"
# Set the partition table to MS-DOS type 
parted -s $HD mklabel gpt &> /dev/null

# Remove any older partitions
parted -s $HD rm 1 &> /dev/null
parted -s $HD rm 2 &> /dev/null
parted -s $HD rm 3 &> /dev/null
parted -s $HD rm 4 &> /dev/null

# Create boot partition
echo "Create boot partition"
parted -s $HD mkpart primary $BOOT_FS $BOOT_START $BOOT_END 1>/dev/null
parted -s $HD set 1 boot on 1>/dev/null

# Create swap partition
echo "Create swap partition"
parted -s $HD mkpart primary linux-swap $SWAP_START $SWAP_END 1>/dev/null

# Create root partition
echo "Create root partition"
parted -s $HD mkpart primary $ROOT_FS $ROOT_START $ROOT_END 1>/dev/null

# Create home partition
echo "Create home partition"
parted -s -- $HD mkpart primary $HOME_FS $HOME_START -0 1>/dev/null

# Formats the root, home and boot partition to the specified file system
echo "Formating boot partition"
mkfs.$BOOT_FS /dev/sda1 -L Boot 1>/dev/null
echo "Formating root partition"
mkfs.$ROOT_FS /dev/sda3 -L Root 1>/dev/null
echo "Formating home partition"
mkfs.$HOME_FS /dev/sda4 -L Home 1>/dev/null
# Initializes the swap
echo "Formating swap partition"
mkswap /dev/sda2
swapon /dev/sda2


echo "Mounting partitions"
# mounts the root partition
mount /dev/sda3 /mnt
# mounts the boot partition
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
# mounts the home partition
mkdir /mnt/home
mount /dev/sda4 /mnt/home


#### Installation
echo "Setting up pacman"
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bkp
sed "s/^Ser/#Ser/" /etc/pacman.d/mirrorlist > /tmp/mirrors
sed '/United States/{n;s/^#//}' /tmp/mirrors > /etc/pacman.d/mirrorlist

if [ "$(uname -m)" = "amd64" ]
then
  cp /etc/pacman.conf /etc/pacman.conf.bkp
  # Adds multilib repository
  sed '/^#\[multilib\]/{s/^#//;n;s/^#//;n;s/^#//}' /etc/pacman.conf > /tmp/pacman
  mv /tmp/pacman /etc/pacman.conf

fi

echo "Running pactrap base base-devel"
pacstrap /mnt base base-devel
echo "Running pactrap grub-bios $EXTRA_PKGS"
pacstrap /mnt grub `echo $EXTRA_PKGS`
echo "Running genfstab"
genfstab -p /mnt >> /mnt/etc/fstab


#### Enters in the new system (chroot)
arch-chroot /mnt << EOF
# Sets hostname
echo $HOSTN > /etc/hostname
cp /etc/hosts /etc/hosts.bkp
sed 's/localhost$/localhost '$HOSTN'/' /etc/hosts > /tmp/hosts
mv /tmp/hosts /etc/hosts
# Configures the keyboard layout
echo 'KEYMAP='$KEYBOARD_LAYOUT > /etc/vconsole.conf
echo 'FONT=lat0-16' >> /etc/vconsole.conf
echo 'FONT_MAP=' >> /etc/vconsole.conf
# Setup locale.gen
cp /etc/locale.gen /etc/locale.gen.bkp
sed 's/^#'$LANGUAGE'/'$LANGUAGE/ /etc/locale.gen > /tmp/locale
mv /tmp/locale /etc/locale.gen
locale-gen
# Setup locale.conf
export LANG=$LANGUAGE'.utf-8'
echo 'LANG='$LANGUAGE'.utf-8' > /etc/locale.conf
echo 'LC_COLLATE=C' >> /etc/locale.conf
echo 'LC_TIME='$LANGUAGE'.utf-8' >> /etc/locale.conf
# Setup clock (date and time)
ln -s /usr/share/zoneinfo/$LOCALE /etc/localtime
echo $LOCALE > /etc/timezone
hwclock --systohc --utc
# Setup the network (DHCP via eth0)
cp /etc/rc.conf /etc/rc.conf.bkp
sed 's/^# interface=/interface=eth0/' /etc/rc.conf > /tmp/rc.conf
mv /tmp/rc.conf /etc/rc.conf
# Setup initial ramdisk environment
mkinitcpio -p linux
# Installs and generates GRUB's settings
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
# Changes the root password
echo -e $ROOT_PASSWD"\n"$ROOT_PASSWD | passwd
git clone -b arch --recurse-submodules https://github.com/kevinjpickard/.dotfiles.git
ansible-playbook --connection=local .dotfiles/core.yml --extra-vars "hostname=$HOSTN username=$USERNAME"
EOF

echo "Umounting partitions"
umount /mnt/{boot,home,}
reboot
