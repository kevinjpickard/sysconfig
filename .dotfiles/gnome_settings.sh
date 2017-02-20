#!/bin/bash
if [ $DESKTOP_SESSION == 'gnome' ]; then
	echo "GNOME DE detected, applying GNOME settings..."
  ## Installing GNOME-shell-manager
  sudo wget -O /usr/local/bin/gnomeshell-extension-manage "https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/ubuntugnome/gnomeshell-extension-manage"
  sudo chmod +x /usr/local/bin/gnomeshell-extension-manage
  
  ## Installing GNOME extensions
    # Dash to Dock
    gnomeshell-extension-manage --install --extension-id 307
    # Sensory Perception
    gnomeshell-extension-manage --install --extension-id 1145
    # Pixel Saver
    gnomeshell-extension-manage --install --extension-id 723
    # Transparent GNOME panel
    gnomeshell-extension-manage --install --extension-id 1099
    # CoverFlow alt-tab
    gnomeshell-extension-manage --install --extension-id 97
    # Multi-Monitors
    gnomeshell-extension-manage --install --extension-id 921
    # Workspaces to dock
    gnomeshell-extension-manage --install --extension-id 427
    # Docker Integration
    gnomeshell-extension-manage --install --extension-id 1055
    # Keys indicator
    gnomeshell-extension-manage --install --extension-id 1105
    # Random Wallpaper
    gnomeshell-extension-manage --install --extension-id 1040
    # Switcher
    gnomeshell-extension-manage --install --extension-id 973

  ## Restarting GNOME
  gnome-shell --replace &

	## settings
	#	Dark theme
	touch ~/.config/gtk-3.0/settings.ini
	echo "[Settings]" >> ~/.config/gtk-3.0/settings.ini
	echo "gtk-application-prefer-dark-theme=1" >> ~/.config/gtk-3.0/settings.ini
	#	Minimize, Maximize
	gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
	
else 
	echo "GNOME DE not detected."
fi
