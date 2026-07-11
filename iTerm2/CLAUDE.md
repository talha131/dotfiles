# iTerm2/ — terminal config

- `com.googlecode.iterm2.plist` — the **source of truth** for iTerm2 settings
  (colors, profiles, keymaps, AI/tmux/paste prefs). iTerm2 reads/writes it here
  when pointed at this folder via Settings → General → "Load settings from a
  custom folder or URL".
- `*.itermcolors` (Gruvbox-Dark, Snazzy), `Default.json` — color schemes /
  profile export.

## Notes

- The plist is a large XML blob, so expect big diffs. Commit it as a single
  "preferences snapshot" — individual settings can't be meaningfully split out.
- A full-state export (`iTerm2 State.itermexport`) was previously tracked but
  is now **gitignored** — it's a large (~40 MB), ephemeral snapshot of open
  windows/scrollback. Do **not** re-add it; settings live in the plist.
