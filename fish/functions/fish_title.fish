function fish_title
    # If this tab has a name pinned via `tabname`, always emit it — and ignore the
    # running command (argv) so the title never flickers between the name and the
    # current command. State is shared across panes by keying on the tab portion of
    # ITERM_SESSION_ID, so every pane in the tab reports the same name.
    if set -q ITERM_SESSION_ID
        set -l statefile $TMPDIR"fish-tabname-"(string match -rg '^(w[0-9]+t[0-9]+)' -- $ITERM_SESSION_ID)
        if test -f $statefile
            read -l pinned <$statefile
            echo -- $pinned
            return
        end
    end

    # --- default fish_title behavior (mirrors embedded:functions/fish_title.fish) ---
    # If we're connected via ssh, we print the hostname.
    set -l ssh
    set -q SSH_TTY
    and set ssh "["(prompt_hostname | string sub -l 10 | string collect)"]"
    # An override for the current command is passed as the first parameter.
    # This is used by `fg` to show the true process name, among others.
    if set -q argv[1]
        echo -- $ssh (string sub -l 20 -- $argv[1]) (prompt_pwd -d 1 -D 1)
    else
        # Don't print "fish" because it's redundant
        set -l command (status current-command)
        if test "$command" = fish
            set command
        end
        echo -- $ssh (string sub -l 20 -- $command) (prompt_pwd -d 1 -D 1)
    end
end
