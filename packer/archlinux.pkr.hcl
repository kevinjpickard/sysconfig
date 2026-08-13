packer {
  required_plugins {
    qemu = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/qemu"
    }
    hyperv = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/hyperv"
    }
    ansible = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

variable "iso_url" {
  type    = string
  default = "https://geo.mirror.pkgbuild.com/iso/latest/archlinux-x86_64.iso"
}

variable "iso_checksum" {
  type    = string
  default = "file:https://geo.mirror.pkgbuild.com/iso/latest/sha256sums.txt"
}

variable "disk_size" {
  type    = string
  default = "40G"
}

variable "ssh_password" {
  type    = string
  default = "testpassword"
}

variable "ssh_username" {
  type    = string
  default = "root"
}

variable "headless" {
  type    = bool
  default = false
}

source "qemu" "archlinux" {
  iso_url          = var.iso_url
  iso_checksum     = var.iso_checksum
  disk_size        = var.disk_size
  format           = "qcow2"
  headless         = var.headless
  memory           = 4096
  cpus             = 2
  accelerator       = "kvm"
  efi_boot          = true
  efi_firmware_code = "/usr/share/edk2/x64/OVMF_CODE.4m.fd"
  efi_firmware_vars = "/usr/share/edk2/x64/OVMF_VARS.4m.fd"
  http_directory    = "archinstall"
  vnc_bind_address = "127.0.0.1"
  vnc_port_min     = 5900
  ssh_username     = var.ssh_username
  ssh_password     = var.ssh_password
  ssh_timeout      = "20m"
  boot_wait        = "75s"
  boot_command = [
    "<enter><wait3>",
    "curl -sO http://{{ .HTTPIP }}:{{ .HTTPPort }}/enable-ssh.sh && bash enable-ssh.sh<enter>"
  ]
  shutdown_command = "shutdown -P 0"
}

source "hyperv-iso" "archlinux" {
  iso_url          = var.iso_url
  iso_checksum     = var.iso_checksum
  disk_size        = 40960
  memory           = 4096
  cpus             = 2
  generation       = 2
  headless         = var.headless
  http_directory   = "archinstall"
  ssh_username     = var.ssh_username
  ssh_password     = var.ssh_password
  ssh_timeout      = "20m"
  boot_wait        = "75s"
  boot_command = [
    "<enter><wait3>",
    "curl -sO http://{{ .HTTPIP }}:{{ .HTTPPort }}/enable-ssh.sh && bash enable-ssh.sh<enter>"
  ]
  shutdown_command = "shutdown -P 0"
}

build {
  sources = [
    "source.qemu.archlinux"
  ]

  provisioner "file" {
    source      = "archinstall/user_configuration.json"
    destination = "/root/user_configuration.json"
  }

  provisioner "file" {
    source      = "archinstall/user_credentials.json"
    destination = "/root/user_credentials.json"
  }

  provisioner "shell" {
    inline = [
      "archinstall --config /root/user_configuration.json --creds /root/user_credentials.json --silent"
    ]
  }

  provisioner "file" {
    source      = "ansible"
    destination = "/mnt/root/ansible"
  }

  provisioner "shell" {
    inline = [
      "arch-chroot /mnt ansible-galaxy collection install -r /root/ansible/requirements.yml",
      "arch-chroot /mnt ansible-playbook --connection=local /root/ansible/setup.yml",
      "BTRFS_UUID=$(findmnt -n -o UUID /mnt)",
      "arch-chroot /mnt efibootmgr -c -d /dev/vda -p 1 -L \"Arch Linux (Fixed)\" -l \\\\vmlinuz-linux -u \"root=UUID=$${BTRFS_UUID} rw rootfstype=btrfs initrd=\\\\initramfs-linux.img\""
    ]
  }
}
