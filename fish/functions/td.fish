function td -d "Create a temporary directory under \$TMPDIR and cd into it" --argument-names account
    set -l name (date +%Y-%m-%d-%H%M%S)
    set -l dir "$TMPDIR$name"
    mkdir -p $dir
    if test $status = 0
        # Write the Claude Code account marker *before* cd'ing in. The
        # __claude_select_account handler fires on the PWD change that `cd`
        # causes, so it only sees markers that already exist; one written
        # afterwards is ignored until PWD changes again (`cd .` is enough).
        if test -n "$account"
            echo $account >$dir/.claude-account
        end
        echo $dir
        cd $dir
    end
end
