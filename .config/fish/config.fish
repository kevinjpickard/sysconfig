function fish_prompt
    ~/scratch/powerline-shell/powerline-shell.py $status --shell bare ^/dev/null
end

set -gx PATH $PATH /usr/local/lib/ruby/gems

source ~/.myenvvars

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
