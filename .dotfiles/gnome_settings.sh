#!/bin/bash
if [ $DESKTOP_SESSION == 'gnome' ]; then
	echo "GNOME DE detected, applying GNOME settings..."
  
  ## Installing GNOME extensions
    # Dash to Dock
    shell-extension-install `gnome-shell --version` 307
    # Sensory Perception
    shell-extension-install `gnome-shell --version` 1145
    # Pixel Saver
    shell-extension-install `gnome-shell --version` 723
    # Transparent GNOME panel
    shell-extension-install `gnome-shell --version` 1099
    # CoverFlow alt-tab
    shell-extension-install `gnome-shell --version` 97
    # Multi-Monitors
    shell-extension-install `gnome-shell --version` 921
    # Workspaces to dock
    shell-extension-install `gnome-shell --version` 427
    # Docker Integration
    shell-extension-install `gnome-shell --version` 1055
    # Keys indicator
    shell-extension-install `gnome-shell --version` 1105
    # Random Wallpaper
    shell-extension-install `gnome-shell --version` 1040
    # Switcher
    shell-extension-install `gnome-shell --version` 973

  ## Restarting GNOME
  gnome-shell --replace &

else 
	echo "GNOME DE not detected."
fi
