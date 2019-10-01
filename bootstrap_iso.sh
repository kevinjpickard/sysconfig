#!/bin/bash
# encoding: utf-8

# Most of this comes from: https://gist.github.com/magnunleno/3641682

##################################################
#       Variables        #
##################################################
# Computer Name
echo 'Enter Hostname:'
read HOSTN

# Username
echo 'Enter username:'
read USERNAME

# Keyboard Layout
KEYBOARD_LAYOUT=us

# Your language, used for localization purposes
LANGUAGE=en_US

# Geography Localization. Verify the directory /usr/share/zoneinfo/<Zone>/<SubZone>
LOCALE=America/Denver

# Root password for the brand new installed system
echo 'Enter root password:'
read -s ROOT_PASSWD

# Crypt Password
echo 'Enter crypt password:'
read -s CRYPT_PASSWD

# User Password
echo 'Enter user password:'
read -s USER_PASSWD

# Device
echo 'Enter block device ID (omit /dev/, i.e. sda, nvme0n1, etc.):'
read BLKID

if [[ $HOSTN -eq $null ]]; then
  HOSTN=KJP-Test
fi

if [[ $USERNAME -eq $null ]]; then
  USERNAME=kevin
fi

if [[ $ROOT_PASSWD -eq $null ]]; then
  ROOT_PASSWD=123456
fi

if [[ $CRYPT_PASSWD -eq $null ]]; then
  CRYPT_PASSWD=123456
fi

if [[ $USER_PASSWD -eq $null ]]; then
  USER_PASSWD=123456
fi

if [[ $BLKID -eq $null ]]; then
  BLKID=nvme0n1
fi

echo "Hostanme: $HOSTN"
echo "Username: $USERNAME"
echo "Root Password: $ROOT_PASSWD"
echo "Crypt Password: $CRYPT_PASSWD"
echo "User Password: $USER_PASSWD"
echo "Block Device ID: $BLKID"

########## Hard Disk Partitioning Variable
# ATTENTION, this script erases ALL YOU HD DATA (specified bt $HD)
# Sizes are in MB
HD="/dev/$BLKID"
# Boot Partition Size: /boot
BOOT_SIZE=1024
# EFI Partition Size: /boot/efi
EFI_SIZE=1024
# Root Partition Size: /
ROOT_SIZE=30720
# Swap partition size: /swap (Based on RAM)
SWAP_SIZE=$(($(grep MemTotal /proc/meminfo | awk '{print $2}')/1000))
echo "Swap: $SWAP_SIZE"
# The /home partition will occupy the remain free space

# Partitions file system
EFI_FS=fat32
BOOT_FS=ext4
HOME_FS=ext4
ROOT_FS=ext4

# Extra packages (not obligatory)
EXTRA_PKGS='ansible efibootmgr git neovim pacman-contrib'

######## Auxiliary variables. THIS SHOULD NOT BE ALTERED
EFI_START=2048
EFI_END=$(($EFI_START+$EFI_SIZE))

BOOT_START=$EFI_END
BOOT_END=$(($BOOT_START+$BOOT_SIZE))

SWAP_START=$BOOT_END
SWAP_END=$(($SWAP_START+$SWAP_SIZE))

##################################################
#       Script       #
##################################################
# Loads the keyboard layout
#loadkeys $KEYBOARD_LAYOUT

#### Partitioning
echo "HD Initialization: $HD"

# Set the partition table to GPT
parted -s $HD mklabel gpt &> /dev/null

# Remove any older partitions
parted -s $HD rm 1 &> /dev/null
parted -s $HD rm 2 &> /dev/null
parted -s $HD rm 3 &> /dev/null
parted -s $HD rm 4 &> /dev/null

# Create EFI Partition
echo "Create EFI Partition"
parted --align optimal -s $HD mkpart primary $EFI_FS $EFI_START $EFI_END
parted -s $HD set 1 esp on 1>/dev/null

# Create boot partition
echo "Create boot partition"
parted -s $HD mkpart primary $BOOT_FS $BOOT_START $BOOT_END 1>/dev/null
parted -s $HD set 2 boot on 1>/dev/null

# Create LVM
echo "Creating LVM"
parted -s $HD mkpart logical ext4 $BOOT_END 100%
echo -n $CRYPT_PASSWD | cryptsetup -c aes-xts-plain64 -y --use-random luksFormat "$HD"p3 -d -
echo -n $CRYPT_PASSWD | cryptsetup luksOpen "$HD"p3 luks -d -
pvcreate /dev/mapper/luks
vgcreate vg0 /dev/mapper/luks

# Create swap partition
echo "Create swap partition"
lvcreate --size $SWAP_SIZE vg0 --name swap

# Create root partition
echo "Create root partition"
lvcreate --size $ROOT_SIZE vg0 --name root

# Create home partition
echo "Create home partition"
lvcreate -l +100%FREE vg0 --name home

# Formats the root, home and boot partition to the specified file system
echo "Formating efi partition"
mkfs.vfat -F32 "$HD"p1 1>/dev/null
echo "Formating boot partition"
mkfs.$BOOT_FS "$HD"p2 -L boot 1>/dev/null
echo "Formating root partition"
mkfs.$ROOT_FS /dev/mapper/vg0-root  1>/dev/null
echo "Formating home partition"
mkfs.$HOME_FS /dev/mapper/vg0-home -L Home 1>/dev/null
# Initializes the swap
echo "Formating swap partition"
mkswap /dev/mapper/vg0-swap
swapon /dev/mapper/vg0-swap


fdisk -l
echo "Mounting partitions"
# mounts the root partition
mount /dev/mapper/vg0-root /mnt
# mounts the boot partition
mkdir /mnt/boot
mount "$HD"p2 /mnt/boot
# mounts the EFI partition
mkdir /mnt/boot/efi
mount "$HD"p1 /mnt/boot/efi
# mounts the home partition
mkdir /mnt/home
mount /dev/mapper/vg0-home /mnt/home

# LVM/GRUB Issue
mkdir /mnt/hostlvm
mount --bind /run/lvm /mnt/hostlvm

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
echo "Running pactrap grub $EXTRA_PKGS"
pacstrap /mnt grub `echo $EXTRA_PKGS`
echo "Running genfstab"
genfstab -p /mnt >> /mnt/etc/fstab

# Due to https://bbs.archlinux.org/viewtopic.php?id=242594
mkdir /mnt/hostlvm
mount --bind /run/lvm /mnt/hostlvm

#### Enters in the new system (chroot)
arch-chroot /mnt << EOF
# To Fix some LVM changes breaking GRUB
ln -s /hostlvm /run/lvm
# Step 2 for LVM/GRUB Issue
arch-chroot /mnt
ln -s /hostlvm /run/lvm
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
grub-install --target=x86_64-efi --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg
# Changes the root password
echo -e $ROOT_PASSWD"\n"$ROOT_PASSWD | passwd
EOF
pacman -Sy --noconfirm --needed ansible
