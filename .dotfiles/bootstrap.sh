#/bin/bash -ex

os=$(uname)

if [[ $os == "Darwin" ]]; then
  echo "Detected macOS, calling Darwin setup scripts..."
  # Install homebrew
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update
  # Install dev tools (xcode)
  echo "Parsing Xcode CLI install command..."
  PROD=$(softwareupdate -l |
    grep "\*.*Command Line" |
    head -n 1 | awk -F"*" '{print $2}' |
    sed -e 's/^ *//' |
    tr -d '\n')
  echo "Installing Xcode..."
  softwareupdate -i "$PROD" --verbose;

  # Clone github .dotfiles repo
  echo "Pulling down system configuration files..."
  git clone --bare https://github.com/kevinjpickard/.dotfiles.git $HOME/.dotfiles
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME fetch
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout osx
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME pull origin osx
  echo ".dotfiles" >> .gitignore
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no
  alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

  # Run OSX Setup script
  ~/.dotfiles/osxsetup.sh
fi

if [[ $os == "Linux" ]]; then
  # Linux setup
  echo "linux detected, calling Linux setup scripts..."
  sudo apt-get install git -y

  ## Clone github .dotfiles repo
  echo "Pulling down system configuration files..."
  rm ~/.bashrc ~/.bash_profile ~/.zshrc README.md ~/.vimrc
  rm -rf ~/.dotfiles
  git clone --bare https://github.com/kevinjpickard/.dotfiles.git $HOME/.dotfiles
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME fetch
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout osx
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME pull origin osx
  echo ".dotfiles" >> .gitignore
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no
  alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

  ~/.dotfiles/linuxsetup.sh
fi
