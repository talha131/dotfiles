# Select which Claude Code account (config dir) to use, based on $PWD.
#
#   x -> ~/.claude                 (default; the original login)
#   y -> ~/.config/claude/y
#
# Opt a project into another account by putting its name in a `.claude-account`
# file at the repo root. Directory prefixes below act as a fallback.

set -g __claude_account_default x

function __claude_account_dir --argument-names account
    switch $account
        case x
            echo $HOME/.claude
        case '*'
            echo $HOME/.config/claude/$account
    end
end

function __claude_select_account --on-variable PWD \
        --description 'Point CLAUDE_CONFIG_DIR at the account for this directory'
    set -l account ''

    # 1. nearest .claude-account marker, walking up from $PWD
    set -l d $PWD
    while test -n "$d" -a "$d" != /
        if test -r $d/.claude-account
            set account (string trim <$d/.claude-account)
            break
        end
        set d (path dirname $d)
    end

    # 2. fall back to directory prefixes
    if test -z "$account"
        switch $PWD
            # case "$HOME/Developer/clientwork/*"
            #     set account y
            case '*'
                set account $__claude_account_default
        end
    end

    # 3. ignore a marker naming an account that was never set up
    set -l dir (__claude_account_dir $account)
    if not test -d $dir
        set dir (__claude_account_dir $__claude_account_default)
    end

    set -gx CLAUDE_CONFIG_DIR $dir
end

__claude_select_account
