# System Configuration

This branch contains a basic, clean NixOS configuration with a KDE Plasma desktop environment.

## NixOS Setup

This configuration uses Flakes. To install or test it:

1. **Install NixOS:**
   Boot into a NixOS live USB/ISO.

2. **Clone the repository:**
   ```bash
   git clone <your-repo-url> /mnt/etc/nixos
   cd /mnt/etc/nixos
   ```

3. **Generate Hardware Configuration:**
   Before installing, you must generate the hardware-specific configuration for your machine or VM:
   ```bash
   nixos-generate-config --root /mnt
   ```
   *Make sure `hardware-configuration.nix` is in the same directory as `configuration.nix` and uncomment its import in `configuration.nix`.*

4. **Install:**
   ```bash
   nixos-install --flake .#nixos-kde
   ```

5. **Rebuild (After Install):**
   Once installed, you can update your system by editing `configuration.nix` or `flake.nix` and running:
   ```bash
   sudo nixos-rebuild switch --flake .#nixos-kde
   ```

## Testing in a VM
You can test this configuration in a VM directly using `nixos-rebuild` (if you are already on a NixOS host with Nix installed):
```bash
nixos-rebuild build-vm --flake .#nixos-kde
./result/bin/run-nixos-kde-vm
```
