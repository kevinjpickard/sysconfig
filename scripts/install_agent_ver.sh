#!/bin/bash

connectKey="$1"
pkgPath="$2"

# run most of the first stage, but don't have it execute the second stage.
curl --silent --show-error --header "x-connect-key: $connectKey" https://kickstart.jumpcloud.com/Kickstart |\
	    head -n '-2' |\
			    sed "s#installScript=.*#installScript=/tmp/secondStage.sh#" > "/tmp/firstStage.sh"

chmod +x "/tmp/firstStage.sh"
bash "/tmp/firstStage.sh"
# now there's a script in /opt/jc/agentInstall.sh that's *almost* what we want.
sed -i "s#bundlePath=.*#bundlePath=$pkgPath#" "/tmp/secondStage.sh"
sed -i 's/.*--output "$bundlePath.*//g' /tmp/secondStage.sh
bash "/tmp/secondStage.sh"
