# Installing Gnome Shell Extensions
mkdir $HOME/Documents/github/scratch/extensions
##	Dash To Dock
wget "https://extensions.gnome.org/download-extension/dash-to-dock@micxgx.gmail.com.shell-extension.zip?version_tag=6553" 
mv "dash-to-dock@micxgx.gmail.com.shell-extension.zip?version_tag=6553" \
 "dash-to-dock@micxgx.gmail.com.shell-extension.zip?version_tag=6553.zip"
mkdir -p "$HOME/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com"
unzip -o "dash-to-dock@micxgx.gmail.com.shell-extension.zip?version_tag=6553.zip" -d "$HOME/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com"

##	Sensory Perception
wget "https://extensions.gnome.org/download-extension/sensory-perception@HarlemSquirrel.github.io.shell-extension.zip?version_tag=6503" 
mv "sensory-perception@HarlemSquirrel.github.io.shell-extension.zip?version_tag=6503" \
	"sensory-perception@HarlemSquirrel.github.io.shell-extension.zip?version_tag=6503.zip"
mkdir -p "$HOME/.local/share/gnome-shell/extensions/sensory-perception@HarlemSquirrel.github.io"
unzip -o "sensory-perception@HarlemSquirrel.github.io.shell-extension.zip?version_tag=6503.zip" -d "$HOME/.local/share/gnome-shell/extensions/sensory-perception@HarlemSquirrel.github.io"

## Pixel Saver
wget "https://extensions.gnome.org/download-extension/pixel-saver@deadalnix.me.shell-extension.zip?version_tag=6419" 
mv "pixel-saver@deadalnix.me.shell-extension.zip?version_tag=6419" \
	"pixel-saver@deadalnix.me.shell-extension.zip?version_tag=6419.zip"
mkdir -p "$HOME/.local/share/gnome-shell/extensions/pixel-saver@deadalnix.me"
unzip -o "pixel-saver@deadalnix.me.shell-extension.zip?version_tag=6419.zip" -d "$HOME/.local/share/gnome-shell/extensions/pixel-saver@deadalnix.me"

## Transparent GNOME Panel
wget "https://extensions.gnome.org/download-extension/transparent-gnome-panel@ttomovcik.com.shell-extension.zip?version_tag=6056" 
mv "transparent-gnome-panel@ttomovcik.com.shell-extension.zip?version_tag=6056" \
	"transparent-gnome-panel@ttomovcik.com.shell-extension.zip?version_tag=6056.zip"
mkdir -p "$HOME/.local/share/gnome-shell/extensions/transparent-gnome-panel@ttomovcik.com"
unzip -o "transparent-gnome-panel@ttomovcik.com.shell-extension.zip?version_tag=6056.zip" -d "$HOME/.local/share/gnome-shell/extensions/transparent-gnome-panel@ttomovcik.com"

## CoverFlow Alt-Tab
wget "https://extensions.gnome.org/download-extension/CoverflowAltTab@palatis.blogspot.com.shell-extension.zip?version_tag=6328" 
mv "CoverflowAltTab@palatis.blogspot.com.shell-extension.zip?version_tag=6328" \
	"CoverflowAltTab@palatis.blogspot.com.shell-extension.zip?version_tag=6328.zip"
mkdir -p "$HOME/.local/share/gnome-shell/extensions/CoverflowAltTab@palatis.blogspot.com"
unzip -o "CoverflowAltTab@palatis.blogspot.com.shell-extension.zip?version_tag=6328.zip" -d "$HOME/.local/share/gnome-shell/extensions/CoverflowAltTab@palatis.blogspot.com"

## Multi-Monitors
wget "https://extensions.gnome.org/download-extension/multi-monitors-add-on@spin83.shell-extension.zip?version_tag=6235" 
mv "multi-monitors-add-on@spin83.shell-extension.zip?version_tag=6235" \
	"multi-monitors-add-on@spin83.shell-extension.zip?version_tag=6235.zip"
mkdir -p "$HOME/.local/share/gnome-shell/extensions/multi-monitors-add-on@spin83"
unzip -o "multi-monitors-add-on@spin83.shell-extension.zip?version_tag=6235.zip" -d "$HOME/.local/share/gnome-shell/extensions/multi-monitors-add-on@spin83"

## Docker Integration
wget "https://extensions.gnome.org/download-extension/docker-integration@jan.trejbal.gmail.com.shell-extension.zip?version_tag=6340" 
mv "docker-integration@jan.trejbal.gmail.com.shell-extension.zip?version_tag=6340" \
	"docker-integration@jan.trejbal.gmail.com.shell-extension.zip?version_tag=6340.zip"
mkdir -p "$HOME/.local/share/gnome-shell/extensions/docker-integration@jan.trejbal.gmail.com"
unzip -o "docker-integration@jan.trejbal.gmail.com.shell-extension.zip?version_tag=6340.zip" -d "$HOME/.local/share/gnome-shell/extensions/docker-integration@jan.trejbal.gmail.com"

## Keys Indicator
wget "https://extensions.gnome.org/download-extension/keys-indicator@caasiu.github.com.shell-extension.zip?version_tag=6488" 
mv "keys-indicator@caasiu.github.com.shell-extension.zip?version_tag=6488" \
	"keys-indicator@caasiu.github.com.shell-extension.zip?version_tag=6488.zip"
mkdir -p "$HOME/.local/share/gnome-shell/extensions/keys-indicator@caasiu.github.com"
unzip -o "keys-indicator@caasiu.github.com.shell-extension.zip?version_tag=6488.zip" -d "$HOME/.local/share/gnome-shell/extensions/keys-indicator@caasiu.github.com"

## Random Wallpaper
wget "https://extensions.gnome.org/download-extension/randomwallpaper@iflow.space.shell-extension.zip?version_tag=6560" 
mv "randomwallpaper@iflow.space.shell-extension.zip?version_tag=6560" \
	"randomwallpaper@iflow.space.shell-extension.zip?version_tag=6560.zip"
mkdir -p "$HOME/.local/share/gnome-shell/extensions/randomwallpaper@iflow.space"
unzip -o "randomwallpaper@iflow.space.shell-extension.zip?version_tag=6560.zip" -d "$HOME/.local/share/gnome-shell/extensions/randomwallpaper@iflow.space"

## Enable Extensions
gnome-shell-extension-tool -e dash-to-dock@micxgx.gmail.com 
gnome-shell-extension-tool -e sensory-perception@HarlemSquirrel.github.io 
gnome-shell-extension-tool -e pixel-saver@deadalnix.me 
gnome-shell-extension-tool -e transparent-gnome-panel@ttomovcik.com 
gnome-shell-extension-tool -e CoverflowAltTab@palatis.blogspot.com 
gnome-shell-extension-tool -e multi-monitors-add-on@spin83 
gnome-shell-extension-tool -e docker-integration@jan.trejbal.gmail.com 
gnome-shell-extension-tool -e keys-indicator@caasiu.github.com 
gnome-shell-extension-tool -e randomwallpaper@iflow.space
