function td -d "Create a temporary directory under \$TMPDIR and cd into it"
    set -l name (date +%Y-%m-%d-%H%M%S)
    set -l dir "$TMPDIR$name"
    mkdir -p $dir
    if test $status = 0
        echo $dir
        cd $dir
    end
end
