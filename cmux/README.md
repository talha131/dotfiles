# cmux — setup reminders

Things to redo when setting up cmux on a fresh machine (or after a reset).
Symlinking the config files is **not** enough — these two steps are manual.

## 1. Install agent hooks

Lets cmux resume Claude Code / other agent sessions mid-conversation across a
quit + relaunch (not just restore the layout).

```fish
cmux hooks setup --yes
```

- **Claude Code needs nothing extra** — its hooks are auto-injected by the cmux
  claude wrapper.
- The command wires up any *other* supported agents found on `PATH` (codex,
  grok, pi, gemini, antigravity, …). Rerun it after installing a new agent.
- Generated files land in each agent's own config dir (`~/.codex`, `~/.grok`,
  `~/.pi`, `~/.gemini`). These are tool-generated — leave them **untracked**.

Verify: open an agent in a surface, `⌘Q`, relaunch — the session should come
back resumed. To restore agents idle instead of auto-resuming, set
`{ "terminal": { "autoResumeAgentSessions": false } }` in `cmux.json`.

## 2. Theme — `Breadog`

The current theme is **`Breadog`** (same for light and dark).

It already lives in `ghostty/config` (`theme = light:Breadog,dark:Breadog`),
which is the **single source of truth** — so once `ghostty/config` is symlinked
into place, the theme applies automatically. Nothing to do on a fresh machine.

To preview or change it, use the picker:

```fish
cmux themes          # interactive picker with live preview
cmux themes list     # plain listing, marks current light/dark
```

⚠️ Don't persist a theme with `cmux themes set` — that writes to the *untracked*
app-managed file (`config.ghostty`) and breaks the single source of truth. To
change the theme for real, edit the `theme =` line in `ghostty/config`. See
`ghostty/CLAUDE.md` and `cmux/CLAUDE.md` for the full rationale.
