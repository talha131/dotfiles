# Disable shortening of characters in path components in the output of prompt_pwd
# https://fishshell.com/docs/current/cmds/prompt_pwd.html
set -g fish_prompt_pwd_dir_length 0

# Environment variables
set -x EDITOR nvim
set -x VIRTUALFISH_HOME ~/.local/share/virtualenvs

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
fzf --fish | source

which bat > /dev/null
and begin
  set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
end

# Add itermocil completions
complete -c itermocil -a "(itermocil --list)"

# bd.fish 
# https://github.com/0rax/fish-bd
# Case insensitive mode: same as seems mode without case sensitity
set -gx BD_OPT 'insensitive'

# done.fish
# https://github.com/franciscolourenco/done
set -U __done_notify_sound 1

# Created by `pipx` on 2024-03-10 10:24:08
set PATH $PATH /Users/talha/.local/bin
set PATH $PATH /Users/talha/Library/Python/3.9/bin

# LLVM
set -gx LDFLAGS "-L/opt/homebrew/opt/llvm/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/llvm/include"
set -gx PATH /opt/homebrew/opt/llvm/bin $PATH


# LLVM
set -gx LLVM_ROOT "/opt/homebrew/opt/llvm/bin"
set -gx PATH /opt/homebrew/opt/llvm/bin $PATH

# Emscripten
source "/Users/talha/Repos/emsdk/emsdk_env.fish"
