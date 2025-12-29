# Editor (used by git, crontab, kubectl, and other tools)
set -x EDITOR nvim

# coreutils (use GNU commands without g prefix)
fish_add_path /opt/homebrew/opt/coreutils/libexec/gnubin

# less (enable ANSI color rendering)
set -gx LESS '-R'

# bat as man pager (colored man pages)
# "bat -plman" messes up the man page formatting
command -q bat && set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}' --height=100%"

if status is-interactive
    # Starship prompt
    starship init fish | source

    # iTerm2 integration
    test -e {$HOME}/.iterm2_shell_integration.fish && source {$HOME}/.iterm2_shell_integration.fish

    # iTermocil completions
    complete -c itermocil -a "(itermocil --list)"

    # Zoxide (replaces autojump)
    zoxide init --cmd j fish | source

    # fzf key bindings
    fzf --fish | source

    # Abbreviations
    abbr -a trash 'trash -v'  # Verbose trash output
end