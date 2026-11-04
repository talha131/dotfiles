# fish/ — fish shell config

Symlinked to `~/.config/fish/`. Layout:

- `config.fish` — env vars, `$PATH`, fzf setup, and abbreviations. (GitHub
  account selection is no longer done here — it's handled statelessly by
  directory via `git/config` credential helpers and the `bin/gh` shim.)
- `functions/` — autoloaded fish functions (one function per file; filename ==
  function name).
- `completions/` — autoloaded tab-completions (one file per command, holding
  `complete` definitions). Symlinked into `~/.config/fish/completions/` like
  `functions/` and `conf.d/`.
- `conf.d/` — auto-sourced at startup. `done.fish` is a vendored plugin (don't
  hand-edit); `fish_frozen_theme.fish` pins the color theme;
  `cmux_project_tab.fish` titles cmux tabs after the Jump/Ustadji projects on
  `cd` (see `cmux/GUIDE.md`). Event handlers (`--on-variable`, `--on-event`)
  must live here, not in `functions/`, which only loads on first call.

## Notes

- Write fish syntax (`set -gx`, `(cmd)`, `if ... end`). Prefer `set -gx` for
  exported globals — `config.fish` was standardized on this over `set -x`.
- Some files are gitignored because they're generated: `fish_variables`,
  `functions/fzf_key_bindings.fish`, `conf.d/virtualfish-loader.fish`. Don't
  track them.
