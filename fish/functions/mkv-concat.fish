function mkv-concat --description "Concatenates multiple MKV files using ffmpeg stream copy"

    # 1. Check for required commands.
    if not command -v ffmpeg >/dev/null; echo "Error: ffmpeg not found." >&2; return 1; end
    if not command -v gdate >/dev/null; echo "Error: gdate not found (brew install coreutils)." >&2; return 1; end

    # 2. Ensure at least one input file is provided.
    if test (count $argv) -eq 0
        echo "Usage: mkv-concat file1.mkv file2.mkv ..." >&2
        return 1
    end

    # 3. Generate a unique output filename.
    set output_file "output-"(gdate +'%Y-%m-%d-%H%M')".mkv"
    echo "➡️ Output file will be: $output_file"

    # 4. Create a secure, temporary file to list the inputs.
    set list_file (mktemp)

    echo "⚙️  Generating list of files with full paths..."
    for file in $argv
        # --- THIS IS THE FINAL, CORRECTED LINE ---
        # It uses 'realpath' to get the full, unambiguous path to each file.
        echo "file '"(realpath $file)"'" >> $list_file
    end

    # 5. Run the ffmpeg command.
    echo "🚀 Starting ffmpeg..."
    if ffmpeg -f concat -safe 0 -i $list_file -c copy $output_file
        echo "✅ Success! Merged files into '$output_file'."
    else
        echo "❌ Error: ffmpeg command failed." >&2
        rm -f $output_file
    end

    # 6. Clean up the temporary list file.
    rm -f $list_file
end
