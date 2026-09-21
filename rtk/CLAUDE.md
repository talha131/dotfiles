# rtk/ — rtk (token-saving CLI proxy) settings

`config.toml` is symlinked to `~/Library/Application Support/rtk/config.toml`.
Link the **file** only: that directory also holds rtk's databases
(`history.db`, `recall.db`, `tee/`), which must not land in the repo.

```fish
ln -s ~/Developer/dotfiles/rtk/config.toml ~/Library/Application\ Support/rtk/config.toml
```

Only overrides live here; missing keys keep rtk's defaults. `rtk config` prints
the effective values, and `rtk rewrite '<cmd>'` shows what the Claude Code hook
would turn a command into (empty output = left alone).

## Why git is excluded

`[hooks] exclude_commands` stops the hook rewriting `git …` to `rtk git …`.
In `claude --worktree` sessions Claude Code refuses any command that names git
as an argument to another program, so the rewrite blocked every commit and
push there. The cost is losing rtk's compressed git output in all sessions.
