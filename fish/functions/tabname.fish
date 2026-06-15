function tabname -d "Pin the iTerm2 tab title; shared across all split panes (no args clears it)"
    # fish re-emits a title escape on every prompt and before every command, and
    # those escapes win over any name we set directly — so the only way to make a
    # name stick is to have fish_title itself emit it. We persist the name in a
    # file keyed by the tab, which fish_title (below) reads on every pane.
    if test "$TERM_PROGRAM" != iTerm.app
        echo "tabname: only works inside iTerm2" >&2
        return 1
    end

    # Panes in the same tab share the "w<window>t<tab>" prefix of ITERM_SESSION_ID
    # (only the trailing "p<pane>:<uuid>" differs), so this key is tab-wide. Every
    # pane's fish_title reads the same file, so the whole tab shows one name and
    # newly split panes inherit it automatically.
    set -l statefile $TMPDIR"fish-tabname-"(string match -rg '^(w[0-9]+t[0-9]+)' -- $ITERM_SESSION_ID)

    if set -q argv[1]
        printf '%s\n' "$argv" >$statefile
    else
        rm -f $statefile
    end

    # Push the name to every pane in the tab right now so switching to an idle pane
    # updates immediately, instead of waiting for that pane to draw its next prompt.
    # fish_title then keeps re-emitting the same value, so the two never disagree.
    osascript \
        -e 'on run argv' \
        -e 'tell application "iTerm2"' \
        -e 'tell current tab of current window' \
        -e 'repeat with s in sessions' \
        -e 'set name of s to (item 1 of argv)' \
        -e 'end repeat' \
        -e 'end tell' \
        -e 'end tell' \
        -e 'end run' \
        -- "$argv" >/dev/null 2>&1
end
