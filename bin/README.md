# bin scripts

Personal utility scripts managed via dotfiles.

Both `my-transcribe` and `my-youtube-subtitles` support two engines: Gemini
(cloud, default) and Whisper (local, offline). See shared setup below.

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
- `--engine` / `-e` — `gemini` (default) or `whisper`
- `--language` / `-l` — same as my-transcribe (free-form for Gemini, codes for Whisper)

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

## my-secure-input

Reports (and optionally alerts on) macOS **Secure Input** state. Secure Input
(Secure Keyboard Entry) blocks *all* global keystroke monitoring — text
expanders (Raycast snippets), clipboard/hotkey managers (PasteNow), and
third-party input methods (Keyman) silently go blind until it's released. Apps
enable it when a password field is *focused* (you needn't type anything), and
Electron apps like Obsidian sometimes leak it and leave it stuck.

### Usage

```
my-secure-input            # show who currently holds Secure Input
my-secure-input --notify   # notify if a non-allowlisted app holds it (silent otherwise)
```

`loginwindow` (screen lock) and terminals are allowlisted; edit `ALLOWLIST` in
the script to taste.

### Background watchdog (launchd)

A launchd agent runs `--notify` every 10s so a stuck Secure Input becomes an
immediate macOS notification instead of a mysterious hours-later failure.
Install it once:

```fish
ln -s ~/Developer/dotfiles/launchd/com.talha131.my-secure-input.plist ~/Library/LaunchAgents/
launchctl bootstrap gui/(id -u) ~/Library/LaunchAgents/com.talha131.my-secure-input.plist
```

To stop/remove it:

```fish
launchctl bootout gui/(id -u)/com.talha131.my-secure-input
```

When alerted, **cleanly quit** the offending app (⌘Q) — never force-kill it, or
the lock orphans onto a dead PID and only a logout/reboot clears it.

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
