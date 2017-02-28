#!/bin/bash
if [ $DESKTOP_SESSION == 'gnome' ]; then
	echo "GNOME DE detected, applying GNOME settings..."
  ## Installing GNOME-shell-manager
  sudo wget -O /usr/local/bin/gnomeshell-extension-manage "https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/ubuntugnome/gnomeshell-extension-manage"
  sudo chmod +x /usr/local/bin/gnomeshell-extension-manage
  
	## extensions
	$HOME/.dotfiles/gnome_extensions.sh

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
