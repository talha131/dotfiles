source ~/.config/fish/functions/marks.fish
eval (python -m virtualfish compat_aliases  auto_activation)
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
