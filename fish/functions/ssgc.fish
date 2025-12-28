# Download and upload SSGC bills
#
# Requires a config file at ~/.local/share/tm-ssgc/bills.txt
# Each line should be: account_number,pcloud_destination_folder
# Example: 1234567890,Documents/Bills/SSGC

function ssgc -d 'Download and backup SSGC bills'
    set config_file ~/.local/share/tm-ssgc/bills.txt

    if not test -f $config_file
        echo "⚠️  Config file not found: $config_file"
        return 1
    end

    set temp (mktemp -d)
    pushd $temp

    for line in (cat $config_file)
        # Skip empty lines
        test -z "$line" && continue

        set entry (string split ',' $line)
        set account (string trim $entry[1])
        set destination (string trim $entry[2])

        # Skip if account is empty
        test -z "$account" && continue

        # Get PDF URL from SSGC (using exact regex pattern from working command)
        set pdf_url (http --form POST "https://viewbill.ssgc.com.pk/web/" b=$account g-recaptcha-response="any_random_text" | rg -o billpdfs\/gasbill[0-9_]\+.pdf | sed 's/^/https:\/\/viewbill.ssgc.com.pk\/web\//')
        echo $pdf_url

        if test -z "$pdf_url"
            echo "⚠️  Could not get PDF for account: $account"
            continue
        end

        set filename (basename $pdf_url)

        # Download
        echo "📥 Downloading $filename"
        http -d "$pdf_url"

        # Upload to pCloud
        echo "📤 Uploading to pcloud:$destination"
        rclone -v copy "$filename" "pcloud:$destination"

        echo "✅ Done: $filename"
    end

    popd
    trash $temp
end
