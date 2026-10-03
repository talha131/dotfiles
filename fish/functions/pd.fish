function pd -d "Create a dated project folder under ~/Developer/Claude-Project and cd into it"
    argparse 'p/prefix=' 'a/account=' -- $argv
    or return
    if test (count $argv) -eq 0
        echo "usage: pd [-p prefix] [-a account] <name>" >&2
        return 1
    end

    # Name comes from all remaining args, so quoting is optional.
    set -l folder (date +%Y-%m-%d)" - $argv"
    # The prefix sits before the date: "GCE - 2026-08-23 - Name".
    if set -q _flag_prefix
        set folder "$_flag_prefix - $folder"
    end
    if string match -q '*/*' -- $folder
        echo "pd: name and prefix must not contain '/'" >&2
        return 1
    end

    set -l account y
    if set -q _flag_account
        set account $_flag_account
    end

    set -l dir "$HOME/Developer/Claude-Project/$folder"
    mkdir -p $dir
    or return
    # Pin the Claude Code account; bin/claude reads the marker at launch.
    # An existing marker is left alone so re-running pd never clobbers it.
    if not test -e $dir/.claude-account
        echo $account >$dir/.claude-account
    end
    echo $dir
    cd $dir
end
