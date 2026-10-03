# Completions for `pd` (see fish/functions/pd.fish).
# The argument is a free-text project name, so suppress file completions.
complete -c pd -f
complete -c pd -s h -l help -d 'Show help'
complete -c pd -s p -l prefix -x -d 'Text placed before the date'
complete -c pd -s a -l account -x -a "x (path basename $HOME/.config/claude/*/)" -d 'Claude Code account for .claude-account'
