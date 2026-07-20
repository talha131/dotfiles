# git/ — git configuration

Symlinked to `~/.config/git/` (`config` is the main gitconfig).

## Dual identity

Both the commit identity **and** the push credentials are chosen by directory,
so nothing depends on `gh`'s global "active account" — pushes are correct in any
shell (not just fish) and safe across parallel agents.

- `config` — personal identity + auth (`talha131@gmail.com` / `talha131`) plus
  all shared settings, aliases, and pager/color config.
- `config-work` — work identity + auth (`talha@jumpdesktop.com` / `smTalhaM`),
  pulled in via `includeIf "gitdir:~/Developer/talha@jumpdesktop.com/"`.

The `includeIf` **must stay at the bottom of `config`**: it overrides both the
identity and the credential helper, and git credential helpers are *additive*,
so `config-work`'s `helper =` reset only wins over the personal helper if it is
parsed last.

The `gh` CLI itself is made directory-aware separately by the `bin/gh` shim,
using the same rule (see `bin/CLAUDE.md`).

## Other files

- `githelper` — shell functions (e.g. `pretty_git_log`) sourced by the
  `l` / `ls` / `lg` / `lp` log aliases.
- `gitignore` — the global `core.excludesfile`.

## Notes

- GPG signing is enabled (`commit.gpgsign = true`) — never disable it.
- Auth uses the `gh` CLI credential helper, pinned per account by injecting
  `GH_TOKEN=$(gh auth token --user <acct>)` so it never reads the global active
  account. SSH URLs are rewritten to HTTPS
  (`url."https://github.com/".insteadOf`).
