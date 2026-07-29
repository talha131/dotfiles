# Setup — deploying these dotfiles

There is **no install script**. Configs are deployed by **symlinking** files
from this repo into place, so editing a tracked file changes the live config
immediately. This file lists the exact symlinks to create on a fresh machine.

Assumes the repo is cloned at `~/Developer/dotfiles` (adjust paths if not).
Commands are shown for **fish** (the login shell), but `ln`/`mkdir`/`rm` behave
the same in any shell.

## The pattern (important)

Each `~/.config/<app>/` is a **real directory**, and individual files/subdirs
inside it are symlinked back to the repo — the parent dir itself is *not* a
symlink. So: make sure the parent dir exists, then symlink each entry.

> ⚠️ **fish auto-creates** `functions/`, `conf.d/`, and `completions/` as real
> (empty) directories on startup. If one already exists as a real dir, remove
> it *before* symlinking, or the `ln` lands *inside* it (a nested
> `completions/completions` link) and fish won't find the files:
> ```fish
> test -d ~/.config/fish/completions; and not test -L ~/.config/fish/completions; and rmdir ~/.config/fish/completions
> ```

---

## fish → `~/.config/fish/`

```fish
mkdir -p ~/.config/fish
ln -s ~/Developer/dotfiles/fish/config.fish   ~/.config/fish/config.fish
ln -s ~/Developer/dotfiles/fish/functions     ~/.config/fish/functions
ln -s ~/Developer/dotfiles/fish/conf.d        ~/.config/fish/conf.d
ln -s ~/Developer/dotfiles/fish/completions   ~/.config/fish/completions
```

(Remove any pre-existing empty `functions/`, `conf.d/`, `completions/` first —
see the fish gotcha above.)

## git → `~/.config/git/`

```fish
mkdir -p ~/.config/git
ln -s ~/Developer/dotfiles/git/config     ~/.config/git/config
ln -s ~/Developer/dotfiles/git/githelper  ~/.config/git/githelper
```

`git/config-work` and `git/gitignore` are **not** symlinked — `git/config`
references them by absolute repo path (an `includeIf` for the work identity,
and `core.excludesfile` respectively), so they work as-is from the repo.

## cmux → `~/.config/cmux/`

```fish
mkdir -p ~/.config/cmux
ln -s ~/Developer/dotfiles/cmux/cmux.json  ~/.config/cmux/cmux.json
```

Reload with `cmux reload-config`. See [`cmux/README.md`](cmux/README.md) and
[`cmux/GUIDE.md`](cmux/GUIDE.md).

## ghostty → `~/.config/ghostty/`

```fish
mkdir -p ~/.config/ghostty
ln -s ~/Developer/dotfiles/ghostty/config  ~/.config/ghostty/config
```

cmux reads this Ghostty file for terminal rendering (font, theme, transparency).
See [`ghostty/CLAUDE.md`](ghostty/CLAUDE.md).

## bin → on `$PATH` (no symlink)

`bin/` is **not** symlinked; `fish/config.fish` adds it to `$PATH` with
`fish_add_path ~/Developer/dotfiles/bin`, so the scripts are available once the
fish config is deployed.

---

## Verify

```fish
# Every entry below should print an arrow (->) to the repo, not "real dir".
for p in ~/.config/fish/config.fish ~/.config/fish/functions ~/.config/fish/conf.d \
         ~/.config/fish/completions ~/.config/git/config ~/.config/git/githelper \
         ~/.config/cmux/cmux.json ~/.config/ghostty/config
    if test -L $p
        echo "$p -> "(readlink $p)
    else
        echo "$p  (MISSING or real dir)"
    end
end
```
