#!/bin/bash
OS=$(cat /etc/issue.net)
if [[ $OS=='Ubuntu 16.04.2 LTS' || $OS=='Zorin OS 12'	]]
then
	curl https://raw.githubusercontent.com/kevinjpickard/.dotfiles/apt/.dotfiles/bootstrap_linux.sh -o ~/.dotfiles/bootstrap_linux.sh
	sudo ~/.dotfiles/bootstrap_linux.sh
elif [[ $(uname -a)=='Darwin*' ]]
then 
	sudo 	~/.dotfiles/osxsetup.sh
fi
