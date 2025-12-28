if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Editor (used by git, crontab, kubectl, and other tools)
set -x EDITOR nvim

# coreutils (use GNU commands without g prefix)
fish_add_path /opt/homebrew/opt/coreutils/libexec/gnubin

# less (enable ANSI color rendering)
set -gx LESS '-R'

# bat as man pager (colored man pages)
# "bat -plman" messes up the man page formatting
command -q bat && set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Starship
starship init fish | source

# iTerm2 integration
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# iTermocil
complete -c itermocil -a "(itermocil --list)"

# ZOxide (Replaces autojump)
zoxide init --cmd j fish | source

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}' --height=100%"

# fzf key binding
fzf --fish | source