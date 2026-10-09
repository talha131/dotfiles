function pd -d "Create a dated project folder under ~/Developer/Claude-Project and cd into it"
    argparse h/help 'p/prefix=' 'a/account=' -- $argv
    or return
    if set -q _flag_help
        echo "usage: pd [-p prefix] [-a account] <name>

Create ~/Developer/Claude-Project/YYYY-MM-DD - <name>, pin its Claude Code
account in .claude-account, cd into it, and report which account claude will
use there. Re-running on the same day reuses the folder and leaves an existing
marker alone.

Options:
  -p, --prefix TEXT     put TEXT before the date: \"TEXT - YYYY-MM-DD - <name>\"
  -a, --account NAME    account for .claude-account (default: y)
  -h, --help            show this help

Examples:
  pd Tax Returns
  pd -p \"GCE - Action Research\" Maryam Shaukat
  pd -a x Some Work Thing"
        return
    end
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
    set -l short (string replace -- $HOME '~' $dir)
    if test -d $dir
        echo "Reusing  $short"
    else
        mkdir -p $dir
        or return
        echo "Created  $short"
    end

    # Pin the Claude Code account; bin/claude reads the marker at launch.
    # An existing marker is left alone so re-running pd never clobbers it.
    set -l marker $dir/.claude-account
    if test -e $marker
        set account (string trim <$marker)[1]
        echo "Kept     .claude-account ($account)"
    else
        echo $account >$marker
        echo "Wrote    .claude-account ($account)"
    end

    # Describe what `claude` will do here, mirroring bin/claude's resolution.
    # Account x keeps its global config in ~/.claude.json; others keep it
    # inside their config dir.
    set -l config $HOME/.claude.json
    if test $account != x
        set config $HOME/.config/claude/$account/.claude.json
    end
    set -l email (jq -r '.oauthAccount.emailAddress // empty' $config 2>/dev/null)
    if test $account != x; and not test -d $HOME/.config/claude/$account
        echo "claude   account $account has no ~/.config/claude/$account; claude will warn and use account x" >&2
    else if test -n "$email"
        echo "claude   runs as $email (account $account)"
    else
        echo "claude   runs as account $account (not logged in)"
    end

    cd $dir
end
