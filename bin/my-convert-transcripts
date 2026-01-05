#!/usr/bin/env python3
"""
Convert VTT transcripts to plain text by stripping cue timestamps and metadata.

Existing .txt files in Assets/Text are left untouched so the script can be
reused safely.
"""

from __future__ import annotations

import argparse
import re
from pathlib import Path
from typing import Iterable, List

TIMESTAMP_RE = re.compile(r"\d{2}:\d{2}:\d{2}\.\d{3}\s+-->", re.UNICODE)
TAG_RE = re.compile(r"<[^>]+>")
LANG_CODE_SUFFIX_RE = re.compile(r"\.[a-z]{2,3}$", re.IGNORECASE)


def vtt_to_lines(path: Path) -> List[str]:
    lines: List[str] = []
    for raw_line in path.read_text(encoding="utf-8").splitlines():
        line = raw_line.strip()
        if not line:
            continue
        if line.startswith(("WEBVTT", "Kind:", "Language:", "NOTE")):
            continue
        if TIMESTAMP_RE.search(line):
            continue
        if line.isdigit():
            # skip cue numbering
            continue
        cleaned = TAG_RE.sub("", line).strip()
        if cleaned:
            lines.append(cleaned)
    return lines


def expected_text_path(vtt_file: Path, text_dir: Path) -> Path:
    name = vtt_file.stem  # drop .vtt
    match = LANG_CODE_SUFFIX_RE.search(name)
    if match:
        name = name[: match.start()]
    return text_dir / f"{name}.txt"


def convert_all(transcript_dir: Path, text_dir: Path) -> None:
    transcript_dir = transcript_dir.resolve()
    text_dir = text_dir.resolve()
    text_dir.mkdir(parents=True, exist_ok=True)

    transcripts = sorted(transcript_dir.glob("*.vtt"))
    if not transcripts:
        print(f"No .vtt files found inside {transcript_dir}")
        return

    for vtt_file in transcripts:
        dest = expected_text_path(vtt_file, text_dir)
        if dest.exists():
            print(f"✓ Text already exists for {vtt_file.name}")
            continue

        print(f"→ Converting {vtt_file.name}")
        lines = vtt_to_lines(vtt_file)
        if not lines:
            print(f"! {vtt_file.name} produced no text after stripping timestamps")
            continue

        dest.write_text("\n".join(lines) + "\n", encoding="utf-8")
        print(f"  wrote {dest.relative_to(text_dir.parent)}")


def main(argv: List[str]) -> None:
    parser = argparse.ArgumentParser(
        description="Convert .vtt transcripts to plain text files.",
    )
    parser.add_argument(
        "--transcript-dir",
        default="Assets/Transcript",
        help="Directory containing .vtt transcripts.",
    )
    parser.add_argument(
        "--text-dir",
        default="Assets/Text",
        help="Directory where .txt outputs should be saved.",
    )

    args = parser.parse_args(argv)
    convert_all(Path(args.transcript_dir), Path(args.text_dir))


if __name__ == "__main__":
    import sys

    main(sys.argv[1:])
