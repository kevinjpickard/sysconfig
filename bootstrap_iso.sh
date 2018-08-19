#!/usr/bin/zsh
sudo pacman -Sy --noconfirm ansible git
git clone -b arch https://github.com/kevinjpickard/.dotfiles.git
ansible-playbook --connection=local .dotfiles/core.yml
# ansible-playbook --connection=local .dotfiles/arch_setup.yml --extra-vars "username=kevin hostname=KJP-test"

# example of how to run a playbook in a chroot
#sudo ansible-playbook -c chroot -i '/path/to/debootstrap,/path/to/febootstrap' my-cool-playbook.yml
