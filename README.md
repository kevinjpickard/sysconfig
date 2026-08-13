# System Configuration & Arch Linux Automation

Automated Arch Linux installation (baremetal or virtualized) with **EFISTUB**, **LUKS + LVM + Btrfs**, **SDDM**, and **KDE Plasma**, plus Ansible configuration management and Molecule VM testing.

---

## 🛠️ Environment & Dependency Setup

To quickly install all required Python development and testing dependencies (`ansible`, `ansible-lint`, `molecule`, `yamllint`) along with required Ansible collections:

```bash
make deps
```

*(Alternatively, run `pip install -r requirements.txt` and `ansible-galaxy collection install -r ansible/requirements.yml`).*

---

## 🚀 Usage Guide

### 1. Baremetal / Virtualized Installation via Live ISO (`archinstall`)

When booted into an official Arch Linux Live ISO, download the automated profiles and run `archinstall`:

```bash
curl -O https://raw.githubusercontent.com/kevinjpickard/sysconfig/main/archinstall/user_configuration.json
curl -O https://raw.githubusercontent.com/kevinjpickard/sysconfig/main/archinstall/user_credentials.json
archinstall --config user_configuration.json --creds user_credentials.json
```

*(Or display this command anytime via `make archinstall-cmd`).*

---

### 2. Local Ansible Provisioning

To provision or sync an existing system using the playbooks, first configure your system's profile:

```bash
cp ansible/local_vars.template.yml ansible/local_vars.yml
# Edit ansible/local_vars.yml to enable/disable specific roles (gaming, dev, etc.)
```

Then apply the playbook:

```bash
make apply
```

*(Or manually: `ansible-galaxy collection install -r ansible/requirements.yml && sudo ansible-playbook --connection=local ansible/setup.yml -e "username=$USER"`).*

---

### 3. Automated VM Building via Packer (HCL2)

Initialize Packer and build a QEMU/KVM virtual machine image:

```bash
make packer-init
make build-vm
```

To target Hyper-V on Windows:

```bash
make build-vm BUILDER=hyperv-iso.archlinux
```

---

### 4. Automated Testing via Molecule

To test Ansible playbooks in an isolated Arch Linux container environment (requires Docker daemon running: `sudo systemctl start docker`):

```bash
make test
```

---

## 📋 Makefile Reference

Run `make` or `make help` to view all available commands:

- `make deps` - Install Python dependencies and Ansible collections
- `make lint` - Run `ansible-lint` on playbooks
- `make test` - Run Molecule test suite
- `make packer-init` - Initialize Packer plugins
- `make build-vm` - Build VM image via Packer (QEMU/KVM default)
- `make apply` - Apply Ansible playbook locally
- `make archinstall-cmd` - Print live ISO boot commands
