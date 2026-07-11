# fish/ — fish shell config

Symlinked to `~/.config/fish/`. Layout:

- `config.fish` — env vars, `$PATH`, fzf setup, abbreviations, and an
  `--on-variable PWD` hook that auto-switches the GitHub account (`gh auth
  switch`) between personal and work dirs under `~/Developer`.
- `functions/` — autoloaded fish functions (one function per file; filename ==
  function name).
- `conf.d/` — auto-sourced at startup. `done.fish` is a vendored plugin (don't
  hand-edit); `fish_frozen_theme.fish` pins the color theme.

## Notes

- Write fish syntax (`set -gx`, `(cmd)`, `if ... end`). Prefer `set -gx` for
  exported globals — `config.fish` was standardized on this over `set -x`.
- Some files are gitignored because they're generated: `fish_variables`,
  `functions/fzf_key_bindings.fish`, `conf.d/virtualfish-loader.fish`. Don't
  track them.
