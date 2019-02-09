# Fish variables
set -g fish_prompt_pwd_dir_length 0

# Environment variables
set -x EDITOR nvim

# Pyenv
status --is-interactive; and source (pyenv init -|psub)
# Virtual Fish (virtual env for python)
eval (python -m virtualfish compat_aliases projects)

# Load shell utilities
source ~/.config/fish/functions/marks.fish
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# Set path
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
set -g fish_user_paths "~/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/llvm@4/bin/" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/ruby/bin" $fish_user_paths

# Golang variables
set -x GOPATH $HOME/Repos/GO
set -x GOBIN $GOPATH/bin
set -x GOVERSION (brew list go | head -n 1 | cut -d '/' -f 6)
set -x GOROOT (brew --prefix)/Cellar/go/$GOVERSION/libexec
set -g fish_user_paths "$GOPATH/bin" $fish_user_paths

# FZF variables
# fzf will use find command (or $FZF_DEFAULT_COMMAND if defined) to 
# list the files under the current directory
set -x FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'
