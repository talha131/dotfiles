function badge -d "Set the iTerm2 badge to the given text"
    # iTerm2's proprietary OSC 1337 SetBadgeFormat expects the value base64-encoded.
    # tr -d '\n' strips the trailing newline base64 adds so the escape sequence stays valid.
    printf '\e]1337;SetBadgeFormat=%s\a' (printf '%s' "$argv" | base64 | tr -d '\n')
end
