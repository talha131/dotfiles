# cmux — Guide (FAQ + notes)

Practical `cmux` CLI notes: marking workspaces done, the sidebar status badges,
and renaming tabs/workspaces/windows. Companion to `CLAUDE.md` and `README.md`
in this folder.

---

## FAQ / quick reference

### ⭐ Mark a workspace state with a visible badge  →  `myws`
```fish
myws done                 # green  ✓ Done   pill on the current workspace
myws active               # blue   ⚡ Active pill (mirrors cmux's "Running")
myws deferred             # gray   ⏸ Deferred pill
myws clear                # remove the pill
myws status               # show current pills + lifecycle lane
myws done workspace:6     # target another workspace by ref/id/index
```
`myws` is a fish function (`fish/functions/myws.fish`) wrapping `cmux set-status`.
The right-click **Status → Done** only sets a *quiet* lifecycle lane with no
bright badge; these pills are the loud, always-visible markers. (Details:
[Shortcut functions](#shortcut-functions-mytab--myws),
[Visible status badges](#visible-status-badges-sidebar-pills).)

### ⭐ Rename the current tab  →  `mytab`
```fish
mytab "dotfiles folder"
```
`mytab` (`fish/functions/mytab.fish`) targets `--surface $CMUX_SURFACE_ID`
because the bare `cmux rename-tab "title"` fails with
`Error: not_found: Tab not found` — the default `$CMUX_TAB_ID` is set to the
*workspace* UUID, not a tab id. (Details:
[Shortcut functions](#shortcut-functions-mytab--myws),
[Renaming](#renaming-tabs-workspaces-and-windows).)

### Other common one-liners
```fish
cmux rename-workspace "Rabia Website"                    # sidebar row
cmux rename-window "work"                                # whole window
cmux workspace status --workspace workspace:6            # read lifecycle lane
cmux workspace status set done --workspace workspace:6   # pin lane (quiet)
cmux tab-action --action clear-name                      # reset tab title to auto
cmux identify --json                                     # what am I? (refs for this surface/tab/ws)
cmux workspace list --json                               # all workspaces + refs
```

---

## Shortcut functions (`mytab` / `myws`)

Two autoloaded fish functions live in `fish/functions/` (symlinked into
`~/.config/fish/functions/`, so they're live in any new shell).

### `mytab <title>` — rename the current tab
```fish
mytab "dotfiles folder"
```
Wraps `cmux rename-tab --surface $CMUX_SURFACE_ID …` to dodge the
`$CMUX_TAB_ID` gotcha (see [Renaming](#renaming-tabs-workspaces-and-windows)).

### `myws <state> [workspace-ref]` — set a workspace state badge
```fish
myws done         myws active       myws deferred      # set a pill (current ws)
myws clear                                             # remove the pill
myws status                                            # list pills + lifecycle lane
myws deferred workspace:6                              # target another workspace
```
Wraps `cmux set-status` using a single pill key (`myws`) so the states are
mutually exclusive — setting a new one replaces the previous. Styling reuses
cmux's own icon/color vocabulary:

| State | Label | Icon | Color |
|---|---|---|---|
| `done` | Done | `checkmark.circle.fill` ✓ | green `#3FB950` |
| `active` | Active | `bolt.fill` ⚡ (like "Running") | blue `#4C8DFF` |
| `deferred` | Deferred | `pause.circle.fill` ⏸ | gray `#8B949E` |

These are **pills**, so unlike the lifecycle lane they persist through agent
activity and won't auto-clear — use `myws clear` to remove one.

---

## Two "status" systems (they're different!)

cmux has **two separate** things both called "status". Don't confuse them.

| | **Lifecycle status** | **Sidebar status pills** |
|---|---|---|
| What | A per-workspace *workflow lane*: todo → working → needs-attention → review → done | Arbitrary colored **pills** attached to a workspace row |
| Set via | Right-click workspace → **Status**, or `cmux workspace status …` | `cmux set-status …` (usually set automatically) |
| Visual | **Quiet** — subtle/dimmed row, no bright badge | **Loud** — colored pill + icon |
| Auto-managed | cmux *infers* the lane from agent activity | The cmux **Claude wrapper** sets `claude_code=Running/idle/…` |
| Auto-clears | A manual pin clears once the inferred lane moves | No — a pill stays until you `clear-status` it |

**The bright "⚡ Running" / "🔔 Needs input" badges in the sidebar are PILLS
(system 2), not the lifecycle status (system 1).** The Claude wrapper populates
them automatically while an agent runs.

---

## Marking a workspace "Done" (lifecycle status)

Right-click menu: **Status → Done** (or `⌘;` = *Mark Workspace as Done*).
From the CLI:

```fish
# Read the current lanes (effective / inferred / override)
cmux workspace status --workspace workspace:6

# Pin a manual lane
cmux workspace status set done --workspace workspace:6
cmux workspace status set auto --workspace workspace:6   # clear the pin (back to auto)
```

Lanes: `todo` `working` `needs-attention` `review` `done` `auto`

Gotchas:

- A manual pin **auto-clears when the inferred lane changes.** Pin "done", then
  run an agent in that workspace → inference moves off `todo` → the pin is
  wiped. Pins only "stick" on quiet workspaces (no running agent). This is why
  a finished, agent-free workspace (e.g. "Rabia Website") is the natural place
  to pin `done`.
- `todo` and `done` render **quietly** — little/no visible marker. That's by
  design. For a *visible* Done badge, add a pill (see the FAQ / below).

### Why lifecycle status exists
It's cmux's triage model for running **many agents in parallel**: each
workspace's lane is auto-inferred from agent activity (running = `working`,
stopped-asking-you = `needs-attention`, quiet = `todo`/`done`), so at a glance
you can see — and cmux can sort — which workspaces are blocked on you vs. done.
The manual pin is the override for when inference can't know (e.g. "this is
finished, park it").

### Agent etiquette
The lifecycle status + checklist "belong to the user." Coding agents should not
set/cycle them unless explicitly asked — inference already tracks agent
activity automatically.

---

## Visible status badges (sidebar pills)

Want a loud, colored marker like the Running/Needs-input badges? Use a pill.

```fish
cmux list-status  --workspace workspace:6                        # list pills
cmux set-status done "Done" --icon checkmark.circle.fill \
    --color "#3FB950" --priority 90 --workspace workspace:6       # add a green ✓ Done pill
cmux clear-status done --workspace workspace:6                    # remove it
```

- `set-status <key> <value>` — `key` namespaces the pill (`claude_code`,
  `build`, `deploy`) so tools don't clobber each other. Use your own key for
  manual pills; `claude_code` is owned by the Claude wrapper.
- Flags: `--icon <sf-symbol>`, `--color "#hex"`, `--priority <n>` (higher first),
  `--workspace <id|ref|index>`.
- A pill does **not** auto-clear (unlike a lifecycle pin), so it can drift out
  of sync with the lane. It's purely cosmetic.

---

## Renaming tabs, workspaces, and windows

Pick the right one — they target different things:

```fish
# Horizontal TAB (a surface). Pass --surface (env var is reliable) or --tab ref.
cmux rename-tab --surface $CMUX_SURFACE_ID "dotfiles folder"
cmux rename-tab --tab tab:3 "build logs"
cmux rename-tab --window window:1 --tab tab:2 "deploy"

# WORKSPACE (the sidebar row, e.g. "Rabia Website")
cmux rename-workspace "Rabia Website"
cmux rename-workspace --workspace workspace:6 "Rabia Website"

# WINDOW (the whole window)
cmux rename-window "work"
```

> ⚠️ **Gotcha:** the bare `cmux rename-tab "title"` (relying on the default
> `$CMUX_TAB_ID`) can fail with `Error: not_found: Tab not found`, because
> `$CMUX_TAB_ID` may hold the *workspace* UUID rather than a tab id. Pass
> `--surface $CMUX_SURFACE_ID` or an explicit `--tab tab:<n>` (get it from
> `cmux identify --json` → `caller.tab_ref`).

Reset a tab back to its automatic title:

```fish
cmux tab-action --action clear-name          # current tab
cmux tab-action --tab tab:3 --action clear-name
```

`rename-tab` is shorthand for the tab's right-click menu, so these are
equivalent:

```fish
cmux rename-tab --surface $CMUX_SURFACE_ID "build logs"
cmux tab-action --surface $CMUX_SURFACE_ID --action rename --title "build logs"
```

Other `tab-action` verbs (same as the tab context menu): `pin` / `unpin`,
`close-left` / `close-right` / `close-others`, `new-terminal-right` /
`new-browser-right`, `move-to-new-workspace`, `reload`, `duplicate`,
`mark-unread`, `toggle-full-width-tab`.

---

## Targets & handy lookups

Most commands take a **ref** (`workspace:2`, `tab:3`, `surface:4`, `window:1`),
a UUID, or an index. Default target is the caller's own workspace/tab (from the
`CMUX_WORKSPACE_ID` / `CMUX_SURFACE_ID` env vars cmux sets per surface — note
`CMUX_TAB_ID` is unreliable, see the rename gotcha above).

```fish
cmux workspace list --json   # workspaces: refs, titles, cwd
cmux identify --json         # what am I? (this surface / tab / workspace / window refs)
cmux tree --all              # full window → workspace → pane → surface tree
```
