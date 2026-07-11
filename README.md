# dotfiles

Personal macOS dotfiles, deployed by **symlinking** files from this repo into
place — there is no install script. Shell is [fish](https://fishshell.com/);
prompt is [Starship](https://starship.rs/).

> **A note on churn:** after ~20 years of a vim/neovim-centric workflow, my
> day-to-day moved to an AI-assisted setup — VS Code for most editing, and
> neovim (currently stock) for long files and regex work. The old editor
> configs have been retired (see [Archived configs](#archived-configs)), so
> this repo is now mostly shell, git, terminal, and personal scripts.

## Layout

| Path        | What it is                                                    | Deployed to                       |
| ----------- | ------------------------------------------------------------- | --------------------------------- |
| `fish/`     | fish config, functions, and auto-loaded `conf.d/`             | `~/.config/fish/`                 |
| `git/`      | git config with split personal/work identity, aliases, helpers | `~/.config/git/`, `~/.gitconfig` |
| `bin/`      | personal CLI scripts (added to `$PATH` by fish)               | on `$PATH`                        |
| `iTerm2/`   | iTerm2 preferences + color schemes                            | iTerm2 custom-prefs folder        |

## bin scripts

Self-contained scripts that run directly — they use `uv` script shebangs, so
their dependencies are provisioned automatically (no venv, no `pip`).
Highlights:

- `my-transcribe` / `my-youtube-subtitles` — audio → text / subtitles (Gemini or local Whisper)
- `my-reddit-to-json` — an `old.reddit.com` HTML page → structured JSON

See [`bin/README.md`](bin/README.md) for full usage.

## Archived configs

Retired editor configs are preserved as annotated git tags rather than kept in
`master`:

| Tag                      | What                                                            |
| ------------------------ | -------------------------------------------------------------- |
| `archive/vim-config`     | 20-year vimscript vim config (`vimrc`, ultisnips, `Vromerc`)   |
| `archive/nvim-vimscript` | vimscript neovim config (vim-plug, coc.nvim, treesitter, codeium) |

Retrieve a file without checking anything out:

```sh
git show archive/nvim-vimscript:nvim/init.vim
```

A fresh neovim config (in Lua) may be rebuilt later, using these as reference.

## Notes

These are personal configs with hardcoded paths and account names — fork and
adapt rather than use directly.
