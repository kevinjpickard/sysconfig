# for some reason, when this suite is run on an Arch Linux host pacman errors out due 
# to some conflicting files and I don't feel like finding a proper fix right now so
# TODO: Do better.
if [[ -d /usr/include/rpcsvc ]]; then
  sudo rm -rf /usr/include/rpcsvc
fi

if [[ -e /usr/lib/libnsl.so ]]; then
  sudo rm /usr/lib/libnsl.so
fi

sudo pacman -Sy --noconfirm ansible
ansible-playbook --connection=local -vvv /tmp/kitchen/.dotfiles/arch.yml
