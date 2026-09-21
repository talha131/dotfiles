# cmux/ — cmux terminal settings

Symlinked to `~/.config/cmux/cmux.json`. cmux is the Ghostty-based terminal
(app bundle `com.cmuxterm.app`).

## What lives here

`cmux.json` holds **cmux-owned** settings only — shortcuts, sidebar,
notifications, browser/automation behavior, workspace colors. Currently the
`⌥1` select-surface-by-number shortcut and link routing (below).

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

Clicked terminal links open in the embedded browser only for personal GitHub
(`github.com/talha131/…`); everything else goes to the system browser. That keeps
the personal GitHub login in the embedded browser and the work one in the
default browser.

Browser settings are global app preferences — a project-local
`.cmux/cmux.json` cannot override them — so routing is by URL, not by project.
`openTerminalLinksInCmuxBrowser` stays `true` and one negative-lookahead rule in
`urlsToAlwaysOpenExternally` forces every non-`talha131` URL out.
`hostsToOpenInEmbeddedBrowser` can't do this: it matches whole hosts, so it
cannot tell GitHub owners apart. To also keep another owner embedded, extend
the alternation: `github\\.com/(talha131|other)(/|$|[?#])`.

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
