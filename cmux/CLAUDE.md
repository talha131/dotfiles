# cmux/ — cmux terminal settings

Symlinked to `~/.config/cmux/cmux.json`. cmux is the Ghostty-based terminal
(app bundle `com.cmuxterm.app`).

## What lives here

`cmux.json` holds **cmux-owned** settings only — shortcuts, sidebar,
notifications, browser/automation behavior, workspace colors. Currently the
`⌥1` select-surface-by-number shortcut and
`browser.openTerminalLinksInCmuxBrowser: false`, which sends clicked terminal
links to the system browser instead of the embedded browser split (it defaults
to `true`).

**Terminal rendering (font, theme, transparency, blur) is NOT here** — it goes
in `ghostty/config` (see `ghostty/CLAUDE.md`). cmux reads that Ghostty file for
all rendering.

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
