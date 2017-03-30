## I'm an idiot, I could've just used Homebrew...but this works. Keeping for reference.

# So Hammerspoon is downloaded from GitHub, and we want the latest release,
# so we must construct the download URL 
LATEST_RELEASE=$(curl -L -s -H 'Accept: application/json' 'https://github.com/Hammerspoon/hammerspoon/releases/latest')
LATEST_VERSION=$(echo $LATEST_RELEASE | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')
DL_URL=https://www.github.com/Hammerspoon/hammerspoon/releases/download/$LATEST_VERSION/Hammerspoon-$LATEST_VERSION.zip

# Now we can download
wget $DL_URL

# Now extract
unzip hammerspoon-$LATEST_VERSION.zip
rm hammerspoon-$LATEST_VERSION.zip
# And finally, move to the applications folder
sudo mv Hammerspoon.app /Applications
