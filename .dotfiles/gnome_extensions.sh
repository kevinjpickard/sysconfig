# Installing Gnome Shell Extensions
mkdir $HOME/Documents/github/scratch/extensions
##	Dash To Dock
wget -o $HOME/Documents/github/scratch/extensions/dashtodock.zip "https://extensions.gnome.org/download-extension/dash-to-dock@micxgx.gmail.com.shell-extension.zip?version_tag=6553" 
mkdir -p "$HOME/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com"
unzip -op $HOME/Documents/github/scratch/extensions/dashtodock.zip -d "$HOME/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com"

##	Sensory Perception
wget -o $HOME/Documents/github/scratch/extensions/sensoryperception.zip "https://extensions.gnome.org/download-extension/sensory-perception@HarlemSquirrel.github.io.shell-extension.zip?version_tag=6503" 
mkdir -p "$HOME/.local/share/gnome-shell/extensions/sensory-perception@HarlemSquirrel.github.io"
unzip -op $HOME/Documents/github/scratch/extensions/sensoryperception.zip -d "$HOME/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com"

## Pixel Saver
wget -o $HOME/Documents/github/scratch/extensions/pixelsaver.zip "https://extensions.gnome.org/download-extension/pixel-saver@deadalnix.me.shell-extension.zip?version_tag=6419" 
mkdir -p "$HOME/.local/share/gnome-shell/extensions/pixel-saver@deadalnix.me"
unzip -op $HOME/Documents/github/scratch/extensions/pixelsaver.zip -d "$HOME/.local/share/gnome-shell/extensions/pixel-saver@deadalnix.me"

## Transparent GNOME Panel
wget -o $HOME/Documents/github/scratch/extensions/transpanel.zip "https://extensions.gnome.org/download-extension/transparent-gnome-panel@ttomovcik.com.shell-extension.zip?version_tag=6056" 
mkdir -p "$HOME/.local/share/gnome-shell/extensions/transparent-gnome-panel@ttomovcik.com"
unzip -op $HOME/Documents/github/scratch/extensions/transpanel.zip -d "$HOME/.local/share/gnome-shell/extensions/transparent-gnome-panel@ttomovcik.com"

## CoverFlow Alt-Tab
wget -o $HOME/Documents/github/scratch/extensions/coverflow.zip "https://extensions.gnome.org/download-extension/CoverflowAltTab@palatis.blogspot.com.shell-extension.zip?version_tag=6328" 
mkdir -p "$HOME/.local/share/gnome-shell/extensions/CoverflowAltTab@palatis.blogspot.com"
unzip -op $HOME/Documents/github/scratch/extensions/coverflow.zip -d "$HOME/.local/share/gnome-shell/extensions/CoverflowAltTab@palatis.blogspot.com"

## Multi-Monitors
wget -o $HOME/Documents/github/scratch/extensions/monitors.zip "https://extensions.gnome.org/download-extension/multi-monitors-add-on@spin83.shell-extension.zip?version_tag=6235" 
mkdir -p "$HOME/.local/share/gnome-shell/extensions/multi-monitors-add-on@spin83"
unzip -op $HOME/Documents/github/scratch/extensions/monitors.zip -d "$HOME/.local/share/gnome-shell/extensions/multi-monitors-add-on@spin83"

## Docker Integration
wget -o $HOME/Documents/github/scratch/extensions/docker.zip "https://extensions.gnome.org/download-extension/docker-integration@jan.trejbal.gmail.com.shell-extension.zip?version_tag=6340" 
mkdir -p "$HOME/.local/share/gnome-shell/extensions/docker-integration@jan.trejbal.gmail.com"
unzip -op $HOME/Documents/github/scratch/extensions/docker.zip -d "$HOME/.local/share/gnome-shell/extensions/docker-integration@jan.trejbal.gmail.com"

## Keys Indicator
wget -o $HOME/Documents/github/scratch/extensions/keys.zip "https://extensions.gnome.org/download-extension/keys-indicator@caasiu.github.com.shell-extension.zip?version_tag=6488" 
mkdir -p "$HOME/.local/share/gnome-shell/extensions/keys-indicator@caasiu.github.com"
unzip -op $HOME/Documents/github/scratch/extensions/keys.zip -d "$HOME/.local/share/gnome-shell/extensions/keys-indicator@caasiu.github.com"

## Random Wallpaper
wget -o $HOME/Documents/github/scratch/extensions/wallpaper.zip "https://extensions.gnome.org/download-extension/randomwallpaper@iflow.space.shell-extension.zip?version_tag=6560" 
mkdir -p "$HOME/.local/share/gnome-shell/extensions/randomwallpaper@iflow.space"
unzip -op $HOME/Documents/github/scratch/extensions/keys.zip -d "$HOME/.local/share/gnome-shell/extensions/randomwallpaper@iflow.space"
