# bin/ — personal CLI scripts

Scripts here are on `$PATH` (added by `fish/config.fish` via
`fish_add_path ~/Developer/dotfiles/bin`), so they run as bare commands.

## Conventions

- **Naming:** user scripts are prefixed `my-*` (e.g. `my-transcribe`,
  `my-reddit-to-json`). No file extension.
- **Self-contained Python:** scripts use a `uv` script shebang
  (`#!/usr/bin/env -S uv run --script`) with PEP 723 inline dependencies
  (a `# /// script` block). `uv` provisions deps automatically — no venv, no
  `pip`, and the user runs them directly (not via `uv run`).
- **Executable:** `chmod +x` any new script.
- **Docs:** document new scripts in `bin/README.md`.
