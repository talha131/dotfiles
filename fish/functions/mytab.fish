function mytab -d 'Rename the current cmux tab'
    if test (count $argv) -eq 0
        echo "usage: mytab <title>" >&2
        return 1
    end
    # $CMUX_TAB_ID is unreliable (often holds the workspace UUID -> "Tab not
    # found"), so target the surface, which is always correct. See cmux/GUIDE.md.
    cmux rename-tab --surface $CMUX_SURFACE_ID "$argv"
end
