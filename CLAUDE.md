# dotfiles — repo guide for Claude

Personal macOS dotfiles. Config files are **symlinked** from this repo into
their real locations (e.g. `~/.config/fish/config.fish` → `fish/config.fish`).
There is **no install script** — symlinks are created manually. Editing a
tracked file here changes the live config immediately.

## Conventions

- **Shell is fish** — use fish syntax in scripts/snippets (`set -gx`, `(cmd)`
  substitution, `if test ...; ...; end`). See the user's global CLAUDE.md.
- **Commits** — one logical change per commit; push after committing (per the
  global CLAUDE.md). GPG signing is on — never disable it.
- **Deployment** — new config only takes effect once symlinked into place.

## Folder guides

Each folder has its own `CLAUDE.md` with specifics: `bin/`, `fish/`, `git/`,
`iTerm2/`.

## Archived editor configs

Old editor configs were removed from `master` but preserved as annotated tags
(the workflow moved to VS Code + stock neovim in the AI era):

| Tag                      | Contents                                                                 |
| ------------------------ | ------------------------------------------------------------------------ |
| `archive/vim-config`     | legacy vimscript vim (`vimrc`, `ultisnips/`, `Vromerc`)                  |
| `archive/nvim-vimscript` | vimscript neovim (`init.vim`, `coc-settings.json`) — vim-plug, coc.nvim, codeium, treesitter |

To reference them (e.g. when rebuilding the nvim config):

```sh
git show archive/nvim-vimscript:nvim/init.vim   # view a single file
git switch -d archive/nvim-vimscript            # browse the full tree
```

**Intent:** the next neovim config will be built **in Lua** from scratch. When
that starts, use `archive/nvim-vimscript` for feature-parity reference (which
plugins and mappings mattered) — do **not** port the vimscript verbatim.
