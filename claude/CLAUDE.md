# claude/ — Claude Code user commands

`commands/` holds user-level slash commands, shared by every account. Each
file is symlinked into each account's config dir (`~/.claude/commands/` for
account `x`, `~/.config/claude/<name>/commands/` for the others):

```fish
for d in ~/.claude ~/.config/claude/*/
    mkdir -p $d/commands
    ln -s ~/Developer/dotfiles/claude/commands/my-park.md $d/commands/my-park.md
end
```

Link files, not the folder: Claude Code writes its own state into the config
dirs. `~/.claude/skills/` is avoided on purpose, because skill sync manages it.

- `my-park.md` — `/my-park` writes a handoff into this session's Obsidian note via
  `bin/my-claude-park handoff`, ahead of exiting and resuming later with `cr`.

## Session parking hook

`settings.json` is not tracked (it holds per-account state), so the SessionEnd
hook that records sessions is added by hand to each account's settings:

```json
"SessionEnd": [
  { "hooks": [ { "type": "command", "command": "$HOME/Developer/dotfiles/bin/my-claude-park hook" } ] }
]
```
