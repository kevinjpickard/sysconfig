# Managing Your System Configuration

This system's configuration is entirely declared and managed by Ansible playbooks in the `sysconfig` repository. To ensure your system stays consistent and up-to-date, try to avoid manually editing configuration files directly if they are managed by Ansible. Instead, update the Ansible playbooks and re-apply them!

## Syncing the System Configuration
When you make a change to the system configuration (such as adding a new package to a role, changing a dotfile, or updating a theme setting), you can apply those changes to your live system using Make:

### Apply all configuration changes (Full Setup)
```bash
# From ~/github.com/kevinjpickard/sysconfig
make apply
```
This runs `ansible/setup.yml` against your local machine. It will configure the base system setup, the Plasma desktop, and optionally (if enabled in your variables) your basic tools, development environments, and gaming tools.

### Sync core configuration only (Quick Sync)
```bash
sudo ansible-playbook --connection=local ansible/sync.yml -e "username=$USER"
```
This runs `ansible/sync.yml` against your local machine, which only targets the `system_setup` and `plasma_desktop` roles. This is useful for quickly syncing core system settings (like your KDE theme or base packages) without running through the heavier development or gaming installations.

## Customizing Your Installation
You can customize which optional roles are applied to your specific machine by creating or editing `ansible/local_vars.yml`.

For example, to enable gaming and development tools, your `ansible/local_vars.yml` might look like:
```yaml
enable_basic_tools: true
enable_dev_tools: true
enable_gaming: true
enable_media: true
enable_virtualization: true
enable_3d_printing: true
```
