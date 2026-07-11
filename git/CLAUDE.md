# git/ — git configuration

Symlinked to `~/.config/git/` (`config` is the main gitconfig).

## Dual identity

- `config` — personal identity (`talha131@gmail.com`) plus all shared settings,
  aliases, and pager/color config.
- `config-work` — work identity (`talha@jumpdesktop.com`), pulled in via
  `includeIf "gitdir:~/Developer/talha@jumpdesktop.com/"`. Fish separately
  switches the `gh` CLI account by directory (see `fish/CLAUDE.md`).

## Other files

- `githelper` — shell functions (e.g. `pretty_git_log`) sourced by the
  `l` / `ls` / `lg` / `lp` log aliases.
- `gitignore` — the global `core.excludesfile`.

## Notes

- GPG signing is enabled (`commit.gpgsign = true`) — never disable it.
- Auth uses the `gh` CLI credential helper, and SSH URLs are rewritten to HTTPS
  (`url."https://github.com/".insteadOf`).
