# cmux/ — cmux terminal settings

Symlinked to `~/.config/cmux/cmux.json`. cmux is the Ghostty-based terminal
(app bundle `com.cmuxterm.app`).

## What lives here

`cmux.json` holds **cmux-owned** settings only — shortcuts, sidebar,
notifications, browser/automation behavior, workspace colors. Currently the
`⌥1` select-surface-by-number shortcut and sending links to the system browser
(below).

**Terminal rendering (font, theme, transparency, blur) is NOT here** — it goes
in `ghostty/config` (see `ghostty/CLAUDE.md`). cmux reads that Ghostty file for
all rendering.

## Claude binary

`automation.claudeBinaryPath` points at `bin/claude`, the account-picking
wrapper. cmux records `/opt/homebrew/bin/claude` for every agent session and
relaunches that path on restore, which skips PATH (and so the wrapper) and
brings the session back on whatever account the shell implies. With the
setting, cmux-launched sessions pick the account from the directory's
`.claude-account` like any other launch.

## Link routing

Every link opens in the system default browser, never cmux's embedded one:
`openTerminalLinksInCmuxBrowser: false` covers clicked terminal links, and
`interceptTerminalOpenCommandInCmuxBrowser: false` covers `open <url>` run in
a terminal (which `gh browse` and similar tools use).

Don't try to route by URL instead. cmux rejects any `urlsToAlwaysOpenExternally`
regex containing `(?` (its regex-safety check, since 0.64), so lookaheads such as
"everything except `github.com/talha131`" silently never match.

## Reload

```fish
cmux reload-config   # reloads BOTH cmux.json and the Ghostty config, live
```

No app restart needed. Validate with `cmux config doctor`.

## Gotcha — the app-managed Ghostty file

`cmux themes ...` writes to `~/Library/Application Support/com.cmuxterm.app/config.ghostty`,
**not** to our tracked `ghostty/config`. That app-managed file is untracked on
purpose: cmux regenerates it from internal state (e.g. `surface-tab-bar-font-size`,
the tab-bar chrome). The terminal *theme* was migrated out of it into the tracked
`ghostty/config` via `cmux themes clear`, so the theme has a single source of
truth. Don't set the theme with `cmux themes set` — edit `ghostty/config` instead,
or it lands in the untracked file.
