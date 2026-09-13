# System Architecture

## Overview
This system is an Arch Linux installation managed by Ansible and bootstrapped via Packer/archinstall. 

## Filesystem
- **Filesystem type**: BTRFS
- **Subvolumes**:
  - `@`: root
  - `@home`: /home
  - `@pkg`: /var/cache/pacman/pkg
  - `@snapshots`: /.snapshots

## Bootloader
- **Type**: systemd-boot / efibootmgr
- **Location**: /boot (ESP)

## Virtualization
VM builds are handled using `qemu`/`hyperv` via Packer, generating a `qcow2` image that can be imported directly into `virt-manager`.
