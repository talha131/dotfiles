# /// script
# dependencies = [
#   "google-genai",
# ]
# ///

import os
import sys
from pathlib import Path

from google import genai

# Setup API Key
# For Fish shell: set -gx GEMINI_API_KEY 'your_key'
api_key = os.getenv("GEMINI_API_KEY")

if not api_key:
    print("Error: Please set the GEMINI_API_KEY environment variable.")
    sys.exit(1)

client = genai.Client(api_key=api_key)

def transcribe_audio(file_path_str):
    file_path = Path(file_path_str)
    
    if not file_path.exists():
        print(f"Error: File '{file_path}' not found.")
        return

    # 1. Upload the file
    print(f"Uploading {file_path.name}...")
    audio_file = client.files.upload(path=str(file_path))
    
    # The prompt for Urdu/English lecture
    prompt = (
        "Transcribe this audio exactly as spoken. The lecture is in a mix of Urdu and English. "
        "Keep the transcription comprehensive, including classroom management and anecdotes. "
        "Do not use timestamps. Use Urdu script for Urdu words and English script for English terms."
    )

    print("Transcribing with Gemini 3 Flash... (this may take a minute)")
    
    try:
        response = client.models.generate_content(
            model="gemini-3-flash-preview",
            contents=[prompt, audio_file],
        )
        transcription_text = response.text

        # 3. Save to a text file with the same name
        # .with_suffix('.txt') changes "lecture.mp3" to "lecture.txt"
        output_file_path = file_path.with_suffix('.txt')
        
        with open(output_file_path, "w", encoding="utf-8") as f:
            f.write(transcription_text)

        print("\n--- SUCCESS ---")
        print(f"Transcription saved to: {output_file_path.name}")
        
    except Exception as e:
        print(f"An error occurred during transcription: {e}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: uv run transcribe.py <path_to_audio_file>")
    else:
        transcribe_audio(sys.argv[1])
