source ~/.config/fish/functions/marks.fish

set PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/shims $PYENV_ROOT/bin $PATH
pyenv rehash

eval (python -m virtualfish compat_aliases  auto_activation)

[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# Load rbenv automatically by appending
status --is-interactive; and . (rbenv init -|psub)

