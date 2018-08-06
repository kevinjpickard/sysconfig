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

# Using command -v for POSIX compatibility
if command -v ansible-playbook > /dev/null; then
  echo 'Ansible is already installed'
else
  echo 'Ansible is not installed, installing now...'
	sudo pacman -Sy --noconfirm --needed ansible
fi

if [[ -e /tmp/kitchen/.dotfiles/arch.retry ]]; then
	ansible-playbook --connection=local /tmp/kitchen/.dotfiles/arch.yml --extra-vars "username=kevin hostname=KJP-test" --limit @/tmp/kitchen/.dotfiles/arch.retry
else
	ansible-playbook --connection=local /tmp/kitchen/.dotfiles/arch.yml --extra-vars "username=kevin hostname=KJP-test nvidia=true"
fi
