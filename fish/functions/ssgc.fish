# Download and upload SSGC bills
#
# Requires a config file at ~/.local/share/tm-ssgc/bills.txt
# Each line should be: account_number,pcloud_destination_folder[,keep]
# Example: 1234567890,Documents/Bills/SSGC
# Example with keep: 1234567890,Documents/Bills/SSGC,keep

function ssgc -d 'Download and backup SSGC bills'
    set config_file ~/.local/share/tm-ssgc/bills.txt

    if not test -f $config_file
        echo "⚠️  Config file not found: $config_file"
        return 1
    end

    set temp (mktemp -d)
    set -l keep_files
    pushd $temp

    for line in (cat $config_file)
        # Skip empty lines
        test -z "$line" && continue

        set entry (string split ',' $line)
        set account (string trim $entry[1])
        set destination (string trim $entry[2])
        set keep_flag (string trim $entry[3] 2>/dev/null)

        # Skip if account is empty
        test -z "$account" && continue

        # Get PDF URL from SSGC. The page links the bill as
        # bill_download.php?f=billpdfs%2Fgasbill_<acct>_<yyyymm>_<timestamp>.pdf
        # (URL-encoded, and gated behind a session cookie), so match the bare
        # filename and rebuild the direct billpdfs/ URL, which needs no session.
        set pdf_url (http --ignore-stdin --form POST "https://viewbill.ssgc.com.pk/web/" b=$account g-recaptcha-response="any_random_text" | rg -o 'gasbill[0-9_]+\.pdf' | head -1 | sed 's|^|https://viewbill.ssgc.com.pk/web/billpdfs/|')

        if test -z "$pdf_url"
            echo "⚠️  Could not get PDF for account: $account (no PDF URL found in response)"
            continue
        end

        set filename (basename $pdf_url)

        # Download
        echo "📥 Downloading $filename"
        http --ignore-stdin -d -o "$filename" "$pdf_url"

        # Upload to pCloud
        echo "📤 Uploading to pcloud:$destination"
        rclone -v copy "$filename" "pcloud:$destination"

        # Track files to keep
        if test "$keep_flag" = "keep"
            set -a keep_files $filename
        end

        echo "✅ Done: $filename"
    end

    # Copy kept files to Downloads
    for f in $keep_files
        cp "$f" ~/Downloads/
        echo "📱 Copied to Downloads for sharing: $f"
    end

    popd

    # Open Downloads if we copied any files
    if test (count $keep_files) -gt 0
        open ~/Downloads
    end

    trash $temp
end
