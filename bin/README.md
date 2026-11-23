# bin scripts

Personal utility scripts managed via dotfiles.

Both `my-transcribe` and `my-youtube-subtitles` support two engines: Whisper
(local, offline, default) and Gemini (cloud). See shared setup below.

### Shared setup

**Gemini (both scripts):**

```fish
# Fish shell
set -gx GEMINI_API_KEY 'your_key'
```

```bash
# Bash / Zsh
export GEMINI_API_KEY='your_key'
```

**Whisper (both scripts):**

```sh
brew install whisper-cpp ffmpeg
mkdir -p ~/.local/share/whisper-cpp
curl -L -o ~/.local/share/whisper-cpp/ggml-large-v3-turbo.bin \
  https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-large-v3-turbo.bin
```

Other models: https://huggingface.co/ggerganov/whisper.cpp/tree/main

---

## my-transcribe

Transcribes audio files to plain text (not subtitles — no timestamps, no
SRT/VTT). The output is saved as a `.txt` file next to the original audio
(e.g. `lecture.mp3` → `lecture.txt`).

### Usage

```
my-transcribe <audio_file> [--engine gemini|whisper] [--language <language>]
my-transcribe --help
```

**Language:** Gemini takes free-form (e.g. `"a mix of Urdu and English"`,
defaults to Urdu/English mix). Whisper takes language codes (e.g. `en`, `ur`,
`auto`, defaults to auto-detect).

**Examples:**

```bash
my-transcribe lecture.mp3
my-transcribe interview.m4a -l "English"
my-transcribe lecture.mp3 -e whisper
my-transcribe lecture.mp3 -e whisper -l ur
```

---

## my-youtube-subtitles

Generates YouTube-compatible subtitle files (VTT or SRT) from audio. The
output is saved next to the original audio (e.g. `lecture.mp3` → `lecture.vtt`).

### Usage

```
my-youtube-subtitles <audio_file> [--engine gemini|whisper] [--format vtt|srt] [--language <language>] [--output <file>]
my-youtube-subtitles --help
```

- `--format` / `-f` — `vtt` (default) or `srt`
- `--output` / `-o` — custom output filename (default: same name as input)
- `--engine` / `-e` — `whisper` (default) or `gemini`
- `--language` / `-l` — same as my-transcribe (free-form for Gemini, codes for Whisper)
- `--chunk-minutes` — Gemini engine: minutes of audio per Gemini request (default: 10)

**Gemini engine:** Gemini writes the words and Whisper supplies the timing,
so it needs the Whisper setup as well as `GEMINI_API_KEY`. Gemini's own
subtitle timestamps are unreliable on long audio, so the script asks it only
for plain text, one ~10-minute part per request, and lines every word up with
Whisper's word timestamps. A part that comes back looping or short (judged
against Whisper's text for the same span) is requested again. A 40-minute
episode takes 4 requests, which fits the Gemini API free tier; rate limits
are waited out and retried automatically.

**Examples:**

```bash
my-youtube-subtitles lecture.mp3
my-youtube-subtitles lecture.mp3 -f srt
my-youtube-subtitles lecture.mp3 -o custom-name.vtt
my-youtube-subtitles lecture.mp3 -e whisper
my-youtube-subtitles lecture.mp3 -e whisper -f srt -l ur
```

---

## my-reddit-to-json

Converts a saved `old.reddit.com` HTML page into structured JSON, preserving
all images, videos, and links from both the original post and every comment
(recursively, at any depth). Dependencies (`beautifulsoup4`) are provisioned
automatically by `uv` — no manual setup needed.

### Usage

```
my-reddit-to-json <input.html> [output.json]
```

If `output.json` is omitted, the JSON is written next to the input with a
`.json` extension.

**Examples:**

```bash
my-reddit-to-json reddit.html            # → reddit.json (auto)
my-reddit-to-json reddit.html out.json   # custom output name
```

---

## gh

A thin shim around the real `gh` CLI (`/opt/homebrew/bin/gh`) that picks the
GitHub account **by current directory** instead of `gh`'s global "active
account". Paths under `~/Developer/talha@jumpdesktop.com/` use the work account
(`smTalhaM`); everywhere else uses personal (`talha131`). It does this by
exporting `GH_TOKEN` for the chosen account, so selection is stateless — correct
in every shell and safe across parallel agents, with no `gh auth switch` races.

This is the naming exception noted in `bin/CLAUDE.md`: the file is named `gh`
(not `my-gh`) so it shadows the real binary via PATH order.

- `gh auth …` is passed straight through untouched (a forced token would break
  `auth status` / `switch` / `login`).
- An explicit `GH_TOKEN` / `GITHUB_TOKEN` in the environment is respected.
- Directory detection is CWD-based, matching git's `includeIf` (see
  `git/config`). Clone a repo into the tree that matches its account.

Git *itself* (push/pull/fetch) is handled separately by per-directory credential
helpers in `git/config` — see `git/CLAUDE.md`. The two share the same rule.

## claude

Shadows the Homebrew `claude` and picks the Claude Code **account** (config
dir) from the nearest `.claude-account` marker, walking up from the current
directory:

| Marker | Result |
| --- | --- |
| `x`, or no marker | `CLAUDE_CONFIG_DIR` unset: the default `~/.claude` |
| `<name>` | `CLAUDE_CONFIG_DIR=~/.config/claude/<name>` |

```fish
echo y > .claude-account   # this directory and everything below it use account y
```

The account is resolved when `claude` launches, not when you `cd`, so it is
correct in every shell whatever its age, and a marker takes effect the moment
it is written. `.claude-account` is in the global gitignore.

- **Account `x` unsets the variable** rather than pointing it at `~/.claude`.
  Claude picks the keychain item by whether `CLAUDE_CONFIG_DIR` is *set*, so an
  explicit `~/.claude` is a separate, second login slot for the same account.
  An inherited `~/.claude` is unset for the same reason.
- A marker naming an account with no config dir prints a warning and falls
  back to the default, rather than silently ignoring the marker.
- **cmux:** cmux prepends a launcher shim, and its wrapper then searches PATH
  for `claude` and finds this script. The script hands off to the next
  `claude` on PATH after itself, and sets `CLAUDE_ACCOUNT_REENTERED` when that
  is a cmux shim, so the second pass skips shims and goes straight to the
  binary. That keeps cmux's integration without looping, whichever comes first
  on PATH. cmux also skips launcher scripts that contain literal re-exec
  phrases, so the script is written to avoid them.

## my-claude-backup

Dated snapshots of the Claude Code config files (`.claude.json`,
`settings.json`) for every account, kept outside the config dirs.

Claude Code has its own rotation in `<config>/backups/`, but it keeps only
five copies — under active use that window can be shorter than an hour, so a
config corrupted overnight has no good copy left by morning.

Accounts are discovered the same way `bin/claude` resolves them: `x` is
`~/.claude`, anything else is `~/.config/claude/<name>`.
Snapshots land in `~/.local/state/claude-config-backups/<account>/<stamp>/`,
newest 30 retained, identical consecutive snapshots skipped.

### Usage

```fish
my-claude-backup                    # snapshot every account
my-claude-backup --list             # show what is stored
my-claude-backup --restore x        # restore newest good snapshot
my-claude-backup --restore x --from 20260920-161500
my-claude-backup --keep 60
```

### Safeguards

- **Never snapshots a broken config.** A copy is only taken if the file
  parses, has an `oauthAccount`, and has completed onboarding — otherwise a
  corrupted config would quietly overwrite the last good snapshot.
- **Refuses to restore under a live session.** A running Claude holds the
  config in memory and rewrites it on exit, which would undo the restore.
  Discovery uses `ps`, not `pgrep` — `pgrep` omits the process the script was
  invoked from, i.e. the very session most likely to clobber it.
- **Atomic writes.** Restores go to a temp file, `fsync`, then `rename()`.
  A truncated config is how these get lost in the first place.
- The file being replaced is kept as `.claude.json.before-restore-<stamp>`.

## my-claude-park

Records Claude Code sessions as Obsidian notes so tabs and workspaces can be
closed freely and the sessions worth keeping picked up again. Notes land in
`~/Developer/My Second Brain/00 Inbox/Claude Sessions/`, one per session.

The loop:

1. **`/my-park`** before exiting a session you want to come back to. Claude
   writes a handoff (goal, done, next, open questions, key files) into the
   note's `## Handoff` section, along with status `parked`, Claude's own title,
   the folder it was launched in, session id, account, and your last five
   prompts. Text after the command, e.g. `/my-park waiting on the client's
   reply`, leads the handoff verbatim as **My summary**. Up to 60 characters,
   it also becomes the note's title and file name, in place of Claude's own
   title. Sessions you exit without `/my-park` get no note.
2. **`cr`** (fish) lists parked sessions in fzf, newest first, with the note as
   preview. Enter moves into the folder, names the cmux tab, marks the note
   `resumed` and runs `claude --resume`. ctrl-d ticks the session's `done` box instead.
   `cr jump` pre-fills the search.
3. A resumed session **leaves `cr`** until you run `/my-park` in it again,
   which rewrites the handoff and sets it back to `parked`.

```fish
cr                                  # pick and resume
my-claude-park list                 # parked sessions, tab-separated
my-claude-park mark <id> done       # tick done without opening it
```

- The resume folder is the one whose encoded name matches the transcript's
  project dir, not the shell's `cwd`, which drifts when Claude `cd`s; resuming
  from any other folder would not find the session.
- Everything above `## Handoff` is regenerated on each `/my-park`, so edit
  freely below it, and add your own properties: they are kept.
- **Finishing a session** means ticking its `done` checkbox, which drops it
  from `cr`; later parks leave a ticked box alone, so only unticking reopens it.
  The vault's `00 Inbox/Claude Sessions.base` shows every session as a table
  (views Open, Done, All, newest first) with that checkbox clickable. It lives
  in the vault, not this repo, along with the `done` (checkbox) and `ended`
  (date & time) types in `.obsidian/types.json`.
- `MY_CLAUDE_PARK_DIR` overrides the notes folder (used for testing).

### Optional: park every session on exit

`my-claude-park hook` is a `SessionEnd` hook that writes or refreshes the note
on **every** interactive exit, `/my-park` or not, and refreshes a resumed
session's note on its next exit. It was on until 2026-11-16 and is now off: it
filled `cr` with sessions nobody meant to come back to. To turn it back on, add
it to each account's `settings.json` (see `claude/CLAUDE.md`).

With it on, `claude -p` runs (`entrypoint` `sdk-cli`) and sessions closed
before any prompt are still skipped, and a note whose handoff predates later
prompts says so.

---

## my-pcloud-upload

Uploads files to the pCloud **Public Folder** and prints a direct
(hotlinkable) `filedn.com` URL for each. Built to be called by other scripts
and Claude sessions, e.g. to replace large media in notes with links.

### Usage

```
my-pcloud-upload [--per-folder N] <file> [<file> ...]
```

- **stdout:** one `<local path>\t<url>` line per file, in input order —
  only for files that are uploaded **and** verified (a HEAD request to the
  public URL must return the local file's size).
- **stderr:** progress, plus `FAILED\t<local path>\t<reason>` per failure.
- **Exit status:** `0` only if every file succeeded, else `1`.

```fish
my-pcloud-upload clip.mp4 diagram.png
my-pcloud-upload ~/Pictures/trip/*.jpg > links.tsv
```

### Behaviour

- **Copies, never moves.** Delete local files yourself once the links are in
  place.
- **Folders:** files land in `Public Folder/share-NNN/`. When the newest
  folder holds `--per-folder` files (default 200), the next one is started.
  Counts are read from pCloud on each run, so there is no local state.
- **Names:** `<slug>-<sha256[:8]>.<ext>` (e.g. `My Trip (1).MP4` →
  `my-trip-1-a3f9c2d1.mp4`). The same content always maps to the same name,
  so re-running after a partial failure skips what's already there and
  returns the same URLs.
- **Bulk:** all files go up in one `rclone copy` (4 parallel transfers).
  Concurrent runs may push a folder slightly past the limit; harmless.
- Requires `rclone` with a `pcloud:` remote.
