PATH := $(HOME)/.asdf/shims:$(HOME)/.local/bin:$(PATH)
export PATH

.PHONY: help deps lint test packer-init build-vm apply archinstall-cmd export-vm remove-vm clean-image

BUILDER ?= qemu.archlinux
VM_NAME ?= sysconfig-qa

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  deps             Install Python dev/test dependencies and Ansible collections"
	@echo "  lint             Run ansible-lint on playbooks"
	@echo "  test             Run Molecule test suite"
	@echo "  packer-init      Ensure Packer is installed and initialize plugins"
	@echo "  build-vm         Build VM image via Packer (default BUILDER=qemu.archlinux)"
	@echo "  apply            Apply Ansible playbook locally"
	@echo "  archinstall-cmd  Print archinstall live ISO boot commands"
	@echo "  export-vm        Import the built VM into libvirt and open virt-manager"
	@echo "  remove-vm        Destroy and undefine the VM from libvirt"
	@echo "  clean-image      Delete the built VM image"

deps:
	pip install -r requirements.txt
	ansible-galaxy collection install -r ansible/requirements.yml

lint:
	ansible-galaxy collection install -r ansible/requirements.yml
	ansible-lint ansible/setup.yml ansible/sync.yml

test: deps
	molecule test

packer-init:
	@if ! command -v packer >/dev/null 2>&1; then \
		echo "Packer is not installed. Attempting installation..."; \
		if command -v pacman >/dev/null 2>&1; then \
			sudo pacman -S --needed --noconfirm packer; \
		elif command -v brew >/dev/null 2>&1; then \
			brew install packer; \
		else \
			echo "Error: Could not automatically install Packer. Please install Packer manually from https://developer.hashicorp.com/packer/downloads" && exit 1; \
		fi; \
	fi
	packer init packer/archlinux.pkr.hcl

build-vm: packer-init
	packer build -force --only=$(BUILDER) packer/archlinux.pkr.hcl

apply:
	ansible-galaxy collection install -r ansible/requirements.yml
	sudo ansible-playbook --connection=local ansible/setup.yml -e "username=$$USER"

archinstall-cmd:
	@echo "On Arch Live ISO, run:"
	@echo "  curl -O https://raw.githubusercontent.com/kevinjpickard/sysconfig/main/archinstall/user_configuration.json"
	@echo "  curl -O https://raw.githubusercontent.com/kevinjpickard/sysconfig/main/archinstall/user_credentials.json"
	@echo "  archinstall --config user_configuration.json --creds user_credentials.json"

export-vm:
	@echo "Importing VM into libvirt..."
	/usr/bin/python3 /usr/bin/virt-install --connect qemu:///session --name $(VM_NAME) --memory 4096 --vcpus 2 --os-variant archlinux \
		--disk path=$(PWD)/output-archlinux/packer-archlinux,format=qcow2 \
		--boot loader=/usr/share/edk2/x64/OVMF_CODE.4m.fd,loader.readonly=yes,loader.type=pflash,nvram.template=$(PWD)/output-archlinux/efivars.fd --import --noautoconsole
	@echo "Launching virt-manager..."
	/usr/bin/python3 /usr/bin/virt-manager --connect qemu:///session --show-domain-console $(VM_NAME) &

remove-vm:
	@echo "Removing VM from libvirt..."
	virsh --connect qemu:///session destroy $(VM_NAME) || true
	virsh --connect qemu:///session undefine $(VM_NAME) || true

clean-image:
	@echo "Deleting built VM image..."
	rm -rf output-archlinux
