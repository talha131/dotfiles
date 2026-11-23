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
    set -l failed
    set -l skipped
    set -l uploaded
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
            echo "❌ Could not get PDF for account: $account (no PDF URL found in response)"
            set -a failed $account
            continue
        end

        set filename (basename $pdf_url)

        # Skip bills already on pCloud. The trailing timestamp in the filename
        # changes on every request, so match on account + bill month only.
        set month (string split _ $filename)[3]
        set listing (rclone lsf "pcloud:$destination" 2>&1)
        if test $status -ne 0
            echo "⚠️  Could not check pCloud for $account ($listing[-1]); downloading anyway"
            set listing
        end
        set existing (string match -- gasbill_$account"_"$month"_*.pdf" $listing)
        if test (count $existing) -gt 0
            echo "⏭️  No new bill for $account: $month is already on pCloud ($existing[-1])"
            set -l answer n
            if isatty stdin
                read -P "   Re-download and upload anyway? [y/N] " answer
            end
            if not string match -qi 'y*' -- $answer
                set -a skipped $account
                continue
            end
        end

        # Download
        echo "📥 Downloading $filename"
        if not http --ignore-stdin --check-status -d -o "$filename" "$pdf_url"
            echo "❌ Download failed for account: $account"
            set -a failed $account
            continue
        end

        # Track files to keep (the local copy is useful even if upload fails)
        if test "$keep_flag" = "keep"
            set -a keep_files $filename
        end

        # Upload to pCloud
        echo "📤 Uploading to pcloud:$destination"
        if not rclone -v copy "$filename" "pcloud:$destination"
            echo "❌ Upload to pCloud FAILED for account: $account"
            set -a failed $account
            continue
        end

        echo "✅ Done: $filename"
        set -a uploaded $account
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

    echo
    if test (count $skipped) -gt 0
        echo "⏭️  $(count $skipped) bill(s) skipped — no new bill on SSGC yet: $skipped"
    end
    if test (count $failed) -gt 0
        echo "❌ $(count $failed) bill(s) FAILED — not on pCloud: $failed"
        return 1
    end
    if test (count $uploaded) -gt 0
        echo "✅ $(count $uploaded) bill(s) downloaded and uploaded to pCloud"
    else
        echo "✅ Nothing new to upload"
    end
end
