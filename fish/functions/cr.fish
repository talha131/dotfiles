function cr -d "Resume a parked Claude session (notes from bin/my-claude-park)"
    # Rows: ended, account, title, short folder, session, folder, note path.
    set -l rows (my-claude-park list)
    if test (count $rows) -eq 0
        echo "cr: no parked sessions" >&2
        return 1
    end

    # Any arguments pre-fill the search.
    set -l out (printf '%s\n' $rows | fzf --delimiter \t --with-nth 1,3,4 \
        --query "$argv" --expect ctrl-d \
        --header 'enter: resume · ctrl-d: mark done' \
        --preview 'cat {7}' --preview-window 'right,50%,wrap')
    or return

    # With --expect, the first line is the key pressed (empty for enter).
    set -l key $out[1]
    set -l f (string split \t -- $out[2])
    set -l title $f[3]
    set -l session $f[5]
    set -l folder $f[6]

    if test "$key" = ctrl-d
        my-claude-park mark $session done
        and echo "Done     $title"
        return
    end

    if not test -d $folder
        echo "cr: folder is gone: $folder" >&2
        return 1
    end
    cd $folder
    if set -q CMUX_SURFACE_ID
        mytab $title >/dev/null
    end
    my-claude-park mark $session resumed
    # bin/claude picks the account from the folder's .claude-account; the
    # flag matches the `claude` abbreviation in config.fish.
    claude --dangerously-skip-permissions --resume $session
end
