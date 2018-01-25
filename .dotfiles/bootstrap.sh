#/bin/bash -ex

os=$(uname)

if [[ $os == "Darwin" ]]; then
  echo "Detected macOS, calling Darwin setup scripts..."

  # Update, if needed. Doesn't seem to install xcode anymore. 
  echo "Checking for updates..."
  PROD=$(softwareupdate -l |
    grep "\*.*Command Line" |
    head -n 1 | awk -F"*" '{print $2}' |
    sed -e 's/^ *//' |
    tr -d '\n')
  softwareupdate -ia "$PROD" --verbose;

  # Install homebrew
  echo "Installing Homebrew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update

  # Clone github .dotfiles repo
  echo "Pulling down system configuration files..."
  git clone --bare https://github.com/kevinjpickard/.dotfiles.git $HOME/.dotfiles
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME fetch
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout master
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME pull origin master
  echo ".dotfiles" >> .gitignore
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no
  alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
  dots push --set-upstream origin master

  # Run OSX Setup script
  ~/.dotfiles/osxsetup.sh
fi

if [[ $os == "Linux" ]]; then
  # Arch
	if [[ -e /etc/arch-release ]]; then
		echo "Detected Arch Linux"
		sudo pacman -Sy git
	else
		# Other Linux setup
		echo "Detected Linux"
		sudo apt-get install git -y
	fi

  ## Clone github .dotfiles repo
  echo "Pulling down system configuration files..."
  rm ~/.bashrc ~/.bash_profile ~/.zshrc README.md ~/.vimrc
  rm -rf ~/.dotfiles
  git clone --bare https://github.com/kevinjpickard/.dotfiles.git $HOME/.dotfiles
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME fetch
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout master
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME pull origin master
  echo ".dotfiles" >> .gitignore
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no
  alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
  dots push --set-upstream origin master

	if [[ -e /etc/arch-release ]]; then 
		~/.dotfiles/arch_setup.sh
	else
		~/.dotfiles/linuxsetup.sh
	fi
fi
