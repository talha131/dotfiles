# Name the cmux tab after the project when the shell enters the Jump or
# Ustadji trees:
#
#   ~/Developer/Ustadji-app                       -> Ustadji
#   ~/Developer/Ustadji-app/.claude/worktrees/x   -> Ustadji · x
#   ~/Developer/talha@jumpdesktop.com/jump-ws     -> jump-ws
#   ~/Developer/talha@jumpdesktop.com/jump-ws-chief -> jump-ws-chief
#
# Renames only when the computed title changes, so cd-ing around one project
# leaves a manual `mytab` alone until you move to another project or worktree.
# Elsewhere the tab is untouched. Lives in conf.d because event handlers must
# be defined at startup; autoloaded functions/ would never see the event.

status is-interactive; or return
set -q CMUX_SURFACE_ID; or return

function __cmux_project_tab --on-variable PWD
    set -l dev $HOME/Developer
    set -l jump $dev/talha@jumpdesktop.com
    set -l project
    switch $PWD
        case $dev/Ustadji-app "$dev/Ustadji-app/*"
            set project Ustadji
        case $jump/jump "$jump/jump/*" "$jump/jump-ws*"
            # The folder name, so sibling clones keep their own name.
            set project (string split / -- (string replace -- $jump/ '' $PWD))[1]
    end

    if test -z "$project"
        # Outside the trees: forget the last title so re-entering renames.
        set -e __cmux_project_tab_last
        return
    end

    set -l title $project
    # Innermost worktree, for worktrees nested inside worktrees.
    set -l worktree (string match -a -r -g '/\.claude/worktrees/([^/]+)' -- $PWD)[-1]
    if test -n "$worktree"
        set title "$project · $worktree"
    end

    test "$title" = "$__cmux_project_tab_last"; and return
    set -g __cmux_project_tab_last $title
    mytab $title >/dev/null
end

# A tab that opens straight into a project (e.g. cmux restoring a session)
# never changes PWD, so title it once now.
__cmux_project_tab
