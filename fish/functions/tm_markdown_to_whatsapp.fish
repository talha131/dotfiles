function tm_markdown_to_whatsapp -d 'Convert Markdown to WhatsApp supported markup'
    set ofile $TMPDIR/markdown_to_whatsapp_6ac597d314.text
    # Replace heading
    cat $argv[1] | sed 's/^#\+ \([[:graph:] ]\+\)/*\1*/' \
    # Remove [TOC] 
    | sed '/^\[TOC\]/d' \
    # Remove Summary
    | sed '/^Summary:\|Keywords:\|Slug\|Tags:\|Date:\|Category:\|Subtitle:\|Comment_id:\|comment_id:/d' \
    # Remove code blocks like ```bash
    | sed 's/^```[[:alpha:]]\+/```/' \
    # Remove singleback tick ` with tripple backtick
    | sed 's/`\{1\}/```/g'  \
    # Unfortunately, above command also affects the code blocks
    | sed 's/^`````````/```/g' \
    # Remove links
    | sed 's/\[\([[:graph:] ]\+\)\]([[:graph:] {}]\+)/\1/' \
    # Remove <mark>
    | sed 's/<mark>/*/' \
    # Remove </mark>
    | sed 's/<\/mark>/*/' \
    # Make title
    | sed 's/^Title: \([[:graph:] ]\+\)/*\1*\n:::::::::::::::::::/' \
    > $ofile

    # Add footer
    cat ~/Dropbox/sync\ onCrashReboot/whatsapp_footer.text >> $ofile
    # Copy to clipboard
    cat $ofile | pbcopy
    # Cleanup
    trash $ofline
end

