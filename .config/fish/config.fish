function fish_prompt
    ~/scratch/powerline-shell/powerline-shell.py $status --shell bare ^/dev/null
end

set -gx PATH $PATH /usr/local/lib/ruby/gems
# Add rvm commands to $PATH
set -gx PATH $PATH ~/.rvm/bin/

# For Google Cloud SDK
set fish_user_paths /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin
set -x MANPATH /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/help/man /usr/local/share/man /usr/share/man /opt/x11/share/man

# GoLang
set PATH $PATH /usr/local/opt/go/libexec/bin
set -gx GOPATH ~/Documents/go/

# Dev Env.
set -x JUMPCLOUD_WORKSPACE ~/Documents/github/jumpcloud/

# Default Vagrant Provider: VirtualBox (Stops translation missing errors)
set -x VAGRANT_DEFAULT_PROVIDER virtualbox

# Add Hyper Plugin paths to $PATH for custom commands
set -x PATH $PATH ~/.hyper_plugins/

# Import my environment variables
source ~/.myenvvars

# Setup nvm environment requirements
set -x NVM_DIR "$HOME/.nvm"
bass source "/usr/local/opt/nvm/nvm.sh"
# Enable Fish as a login shell to fix some nvm behavior (use <version>)
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
rvm default
