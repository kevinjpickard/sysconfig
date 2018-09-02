# System Configuration
My system config files. This includes ansible playbooks and shell scripts to automate sytem setup. 

## Arch Linux

```
curl https://raw.githubusercontent.com/kevinjpickard/.dotfiles/bootstrap_iso.sh -o bootrap_iso.sh && bash ./bootstrap_iso.sh
```

## Testing:
Just the ansible playbook:
```
kitchen test archlinux
```
Full setup script:
```
packer build -force --only virtualbox-iso archlinux.json
```

