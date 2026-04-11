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
