# .dotfiles
My system config files

```
curl https://raw.githubusercontent.com/kevinjpickard/.dotfiles/arch/.dotfiles/bootstrap.sh | bash
```

## To test:
Just the ansible playbook:
```
kitchen test archlinux
```
Full setup script:
```
packer build -force --only virtualbox-iso archlinux.json
```

