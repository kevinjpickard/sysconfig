#echo 'Sourcing ~/.zshrc...'
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
#echo 'Exporting ZSH...'
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random" # it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="bureau"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"
## Automatically accept update
#echo 'Disabling update prompt...'
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
#echo 'Enabling completion dots...'
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#echo 'Initializing plugins...'
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

#echo 'Initializing oh-my-zsh...'
source $ZSH/oh-my-zsh.sh

# User configuration

# GO env
#echo 'Setting up GO env...'
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export GOEXE="$GOPATH/exe"

# export MANPATH="/usr/local/man:$MANPATH"

# OSX env
if [[ $OSTYPE == darwin* ]]; then
  #echo 'Setting up macOS env...'
  source ~/.myenvvars

  # Homebrew installs + coreutils
  export PATH="/usr/local/Cellar:$PATH"
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
  
  # Agent version check
  alias vcheck='python ~/scripts/vcheck.py'
fi

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Completions
## ZSH
#echo 'Initializing ZSH completions...'
fpath=(/usr/local/share/zsh-completions $fpath)
#echo 'Initializing Google Cloud SDK completions...'
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#echo 'Starting powerline...'
#. /usr/local/lib/python3.6/*-packages/powerline/bindings/zsh/powerline.zsh

#echo 'Setting up JumpCloud workspace...'
export JUMPCLOUD_WORKSPACE='/Users/kevin/go/src/github.com/TheJumpCloud'
export PGDATA='/var/lib/postgresql/data/pgdata'

#echo 'Setting git editor...'
export GIT_EDITOR='/Applications/MacVim.app/Contents/MacOS/Vim -gf '

#echo 'Initializing NVM...'
nvm() { # Lazy-Loading NVM to speed up shell start
  unset -f nvm
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
  nvm "$@"
}

# SSH AUTH SOCKET for docker shtuff (OSX Only)
#export SSH_AUTH_SOCK=/tmp/ssh-4dvkFlwhJY/agent.3217
#PGDATA=/var/lib/postgresql/data/pgdata
#alias vcheck="python ~/scripts/vcheck.py"

# added by travis gem
#echo 'Initializing TravisCI gem completions...'
[ -f /Users/kevin/.travis/travis.sh ] && source /Users/kevin/.travis/travis.sh

#echo 'Initializing RBENV...'
export RBENV_VERSION="2.4.1"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# added by Miniconda3 4.3.21 installer
export PATH="/Users/kevin/miniconda3/bin:$PATH"

# For all those times you just fuck up
eval $(thefuck --alias)

# Alias to update all git repos in a directory
alias gitpullall='find . -maxdepth 1 -type d -exec sh -c "(cd {} && pwd && git pull origin)" ";"'

# Use NeoVim if it is installed
if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi

# Set config home
export XDG_CONFIG_HOME=~/.config

# Miniconda
#export PYTHONPATH=/usr/local/miniconda3/bin:$PYTHONPATH

export PATH="/usr/local/opt/mongodb@3.0/bin:$PATH"
source ~/scratch/goto/goto.bash
source ~/.antigen/init.zsh

# Antigen pkg manager
antigen use oh-my-zsh
antigen theme bureau
antigen bundle desyncr/auto-ls
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

antigen apply

#echo 'Setting up aliases...'
alias ll='ls --color=auto -lhaH'
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias tre='tree -CDFfpugha'
