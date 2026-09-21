function td -d "Create a temporary directory under \$TMPDIR and cd into it" --argument-names account
    set -l name (date +%Y-%m-%d-%H%M%S)
    set -l dir "$TMPDIR$name"
    mkdir -p $dir
    if test $status = 0
        # Pin the Claude Code account for this scratch dir; bin/claude reads
        # the marker each time it launches.
        if test -n "$account"
            echo $account >$dir/.claude-account
        end
        echo $dir
        cd $dir
    end
end
