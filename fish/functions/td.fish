function td -d "Create a temporary directory under \$TMPDIR and cd into it" --argument-names account
    set -l name (date +%Y-%m-%d-%H%M%S)
    set -l dir "$TMPDIR$name"
    mkdir -p $dir
    if test $status = 0
        # Pin the Claude Code account for this scratch dir; bin/claude reads
        # the marker each time it launches. Defaults to y, like pd.
        if test -z "$account"
            set account y
        end
        echo $account >$dir/.claude-account
        echo $dir
        cd $dir
        # Name the cmux tab; the time tells several scratch tabs apart.
        if set -q CMUX_SURFACE_ID
            mytab "Temp task "(date +%H:%M)
        end
    end
end
