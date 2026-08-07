#!/bin/bash -x

# for some reason, when this suite is run on an Arch Linux host pacman errors out due
# to some conflicting files and I don't feel like finding a proper fix right now so
# TODO: Do better.
if [[ -d /usr/include/rpcsvc ]]; then
  sudo rm -rf /usr/include/rpcsvc
fi

if [[ -e /usr/lib/libnsl.so ]]; then
  sudo rm /usr/lib/libnsl.so
fi

if [[ $OSTYPE == darwin* ]]; then
  echo "Detected MacOS"

  read HOST_NAME
  read -s SUDO_PASSWD
  sudo -v

  echo $SUDO_PASSWD
  echo "Installing updates..."
  softwareupdate -lia

  echo "Installing HomeBrew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  echo "Brew installed. Installing Ansible..."
  brew install ansible

  echo "Ansible installed. Cloning files..."
  brew install git
  git clone https://github.com/kevinjpickard/sysconfig.git

  echo "Executing playbook..."
  sudo ansible-playbook --connection=local ~/sysconfig/ansible/sync.yml --extra-vars "username=$USER hostname=$HOST_NAME ansible_sudo_pass=$SUDO_PASSWD" -vvv
else
  # Using command -v for POSIX compatibility
  if command -v ansible-playbook > /dev/null; then
    echo 'Ansible is already installed'
  else
    echo 'Ansible is not installed, installing now...'
    sudo pacman -Syyu --noconfirm --needed ansible
  fi

  if [[ -e /kitchen/ansible/sync.retry ]]; then
    ANSIBLE_LIBRARY="/kitchen/ansible/library/aur:$ANSIBLE_LIBRARY" ansible-playbook --connection=local /kitchen/ansisble/sync.yml --extra-vars "username=kevin hostname=KJP-test" --limit @/kitchen/ansible/sync.retry -vvv
  else
    ANSIBLE_LIBRARY="/kitchen/ansible/library/aur:$ANSIBLE_LIBRARY" ansible-playbook --connection=local /kitchen/ansible/sync.yml --extra-vars "username=kevin hostname=KJP-test" -vvv
  fi
fi
