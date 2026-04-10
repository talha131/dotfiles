# bin scripts

Personal utility scripts managed via dotfiles.

## my-transcribe

Transcribes audio files to plain text (not subtitles — no timestamps, no
SRT/VTT). The output is saved as a `.txt` file next to the original audio
(e.g. `lecture.mp3` → `lecture.txt`).

### Usage

```
my-transcribe <audio_file> [--engine gemini|whisper] [--language <language>]
my-transcribe --help
```

### Gemini engine (default)

Uses Google's Gemini API. Fast and high quality, but requires internet.

**Setup:**

```fish
# Fish shell
set -gx GEMINI_API_KEY 'your_key'
```

```bash
# Bash / Zsh
export GEMINI_API_KEY='your_key'
```

**Language:** free-form string via `--language` (e.g. `"English"`,
`"a mix of Urdu and English"`). Defaults to a mix of Urdu and English.

**Examples:**

```bash
my-transcribe lecture.mp3
my-transcribe interview.m4a -l "English"
```

### Whisper engine (local)

Uses whisper.cpp locally. Runs offline, no API key needed.

**Setup:**

```sh
# 1. Install whisper-cpp and ffmpeg
brew install whisper-cpp ffmpeg

# 2. Download a model
mkdir -p ~/.local/share/whisper-cpp
curl -L -o ~/.local/share/whisper-cpp/ggml-large-v3-turbo.bin \
  https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-large-v3-turbo.bin
```

Other models available at: https://huggingface.co/ggerganov/whisper.cpp/tree/main

**Language:** language code via `--language` (e.g. `en`, `ur`, `auto`).
Defaults to auto-detect.
Full list of codes: https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes

**Examples:**

```bash
my-transcribe lecture.mp3 --engine whisper
my-transcribe lecture.mp3 -e whisper -l ur
```
