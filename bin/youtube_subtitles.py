# /// script
# dependencies = [
#   "google-genai",
# ]
# ///

"""
Generate a YouTube-compatible .srt subtitle file from an audio recording
using the Gemini API. The script mirrors the authentication pattern used
by transcribe.py but asks the model to return timed captions instead of
a plain transcript.
"""

from __future__ import annotations

import os
import sys
from pathlib import Path
from typing import Optional

from google import genai


def build_client() -> genai.Client:
    """Return a configured Gemini client or exit with a helpful error."""
    api_key = os.getenv("GEMINI_API_KEY")
    if not api_key:
        print("Error: Please set the GEMINI_API_KEY environment variable.")
        sys.exit(1)
    return genai.Client(api_key=api_key)


def clean_srt_text(raw_text: Optional[str]) -> str:
    """
    Remove Markdown fences or stray prefixes Gemini might add so that the
    saved file is a pure SubRip document.
    """
    if not raw_text:
        return ""

    text = raw_text.strip()
    if "```" in text:
        lines = []
        for line in text.splitlines():
            stripped = line.strip()
            if stripped.startswith("```"):
                continue
            lines.append(line)
        text = "\n".join(lines).strip()
    return text


def build_prompt() -> str:
    """Prompt that asks the model to emit valid SRT captions."""
    return (
        "You are preparing subtitles for YouTube.\n"
        "Listen to the audio and return a strictly valid SubRip (.srt) file.\n"
        "Rules:\n"
        "1. Begin numbering at 1 and increment by 1 for each cue.\n"
        "2. Use the HH:MM:SS,mmm timestamp format (e.g., 00:01:02,500).\n"
        "3. Keep each caption shorter than ~2 lines and under 7 seconds when possible.\n"
        "4. Use Urdu script for Urdu words and English for English terms, matching the audio.\n"
        "5. Do not include translations, descriptions, or explanations—only the spoken words.\n"
        "6. Output nothing except the final SRT content (no Markdown fences or comments).\n"
    )


def generate_youtube_subtitles(file_path_str: str) -> None:
    """Upload audio, request SRT subtitles from Gemini, and save them."""
    client = build_client()
    audio_path = Path(file_path_str)
    if not audio_path.exists():
        print(f"Error: File '{audio_path}' not found.")
        return

    print(f"Uploading {audio_path.name}...")
    audio_file = client.files.upload(path=str(audio_path))

    prompt = build_prompt()

    print("Generating YouTube subtitles with Gemini 3 Flash Preview...")
    try:
        response = client.models.generate_content(
            model="gemini-3-flash-preview",
            contents=[prompt, audio_file],
        )
        srt_text = clean_srt_text(response.text)
        if not srt_text:
            print("Error: Gemini response was empty.")
            return

        output_path = audio_path.with_suffix(".srt")
        with open(output_path, "w", encoding="utf-8") as fh:
            fh.write(srt_text)

        print("\n--- SUCCESS ---")
        print(f"Subtitle file saved to: {output_path.name}")
    except Exception as exc:
        print(f"An error occurred while generating subtitles: {exc}")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: uv run youtube_subtitles.py <path_to_audio_file>")
    else:
        generate_youtube_subtitles(sys.argv[1])
