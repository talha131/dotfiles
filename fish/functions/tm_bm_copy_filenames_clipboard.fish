function tm_bm_copy_filenames_clipboard -d 'Copies filenames in the folder to clipboard without extension'
    for f in $argv/*
        if test -f $f
            set a (tm_split_path $f)
            echo $a[1]
        end
    end | pbcopy
end

