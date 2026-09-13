# System Cheatsheet

## Managing Your Configuration
*   **View this manual**: `sysman`
*   **Apply system changes (Full)**: `make apply` (Run this from `~/github.com/kevinjpickard/sysconfig`)
*   **Quick Sync (Core only)**: `sudo ansible-playbook --connection=local ansible/sync.yml -e "username=$USER"`

## Arch Linux Package Management (pacman/yay)
Your system uses Arch Linux, which has two main repositories: the official repos (pacman) and the Arch User Repository (AUR). You can use `yay` to manage both!

*   **Update the entire system**: `yay -Syu`
*   **Search for a package**: `yay -Ss <search-term>`
*   **Install a package**: `yay -S <package-name>`
*   **Remove a package**: `yay -Rns <package-name>` (This safely removes the package AND its unused dependencies)
*   **Clean package cache**: `yay -Sc` (Frees up disk space by removing old downloaded packages)

## System Services (systemd)
*   **Check status of a service**: `systemctl status <service>`
*   **Start/Stop a service**: `sudo systemctl start|stop <service>`
*   **Enable a service to start at boot**: `sudo systemctl enable --now <service>`

## Virtual Machines (Packer)
If you are developing the system configuration, you can test it safely in a VM before applying it to bare-metal.
*   **Build the VM image**: `make build-vm` (Uses QEMU/Packer to build an Arch image)
*   **Import and boot the VM**: `make export-vm` (Loads it into libvirt/virt-manager and opens the console)
*   **Destroy the test VM**: `make remove-vm`
*   **Clean up image files**: `make clean-image`

## Theming & UI
*   Your system uses **KDE Plasma** with the **Dracula** theme and **Kvantum** widget style.
*   If your UI ever completely freezes but your mouse still moves, you can restart Plasma without rebooting by pressing `Alt+Space` (to open KRunner) and typing: `kquitapp6 plasmashell && kstart6 plasmashell`.
