# Fish variables
set -g fish_prompt_pwd_dir_length 0

# Environment variables
set -x EDITOR nvim

# Load shell utilities
source ~/.config/fish/functions/marks.fish
# autojump
[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish
# iTerm2 integration
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# Set path
## Path of homebrew packages
fish_add_path /opt/homebrew/bin

# ruby gem variables
set -x GEM_HOME $HOME/.gem
set -x GEM_ROOT $HOME/.gem
fish_add_path /opt/homebrew/opt/ruby/bin
set -g fish_user_paths $GEM_HOME/bin $fish_user_paths
set -g fish_user_paths (ruby -e 'puts Gem.user_dir')/bin $fish_user_paths

# Golang variables
set -x GOPATH $HOME/Repos/GO
set -x GOBIN $GOPATH/bin
set -g fish_user_paths "$GOPATH/bin" $fish_user_paths

# FZF variables
# fzf will use find command (or $FZF_DEFAULT_COMMAND if defined) to 
# list the files under the current directory
set -x FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'

which bat > /dev/null
and begin
  set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
end

# Add itermocil completions
complete -c itermocil -a "(itermocil --list)"
