sudo pacman -Sy ansible --noconfirm
ansible-playbook --connection=local /tmp/kitchen/.dotfiles/arch.yml
