function myws -d 'Set a cmux workspace state pill (done/active/deferred)'
    set -l state $argv[1]
    # Optional 2nd arg = workspace ref/id/index; default = current workspace.
    set -l ws $argv[2]
    test -z "$ws"; and set ws $CMUX_WORKSPACE_ID

    # Single pill slot so states are mutually exclusive (a new state overwrites
    # the previous one). Reuses cmux's own icon/color vocabulary. See cmux/GUIDE.md.
    set -l key myws

    switch $state
        case done
            cmux set-status $key Done --icon checkmark.circle.fill --color '#3FB950' --priority 90 --workspace $ws
        case active
            cmux set-status $key Active --icon bolt.fill --color '#4C8DFF' --priority 90 --workspace $ws
        case deferred defer
            cmux set-status $key Deferred --icon pause.circle.fill --color '#8B949E' --priority 90 --workspace $ws
        case clear none
            cmux clear-status $key --workspace $ws
        case status ''
            cmux list-status --workspace $ws
            cmux workspace status --workspace $ws
        case '*'
            echo "myws: unknown state '$state'" >&2
            echo "usage: myws <done|active|deferred|clear|status> [workspace-ref]" >&2
            return 1
    end
end
