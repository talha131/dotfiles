function tm_filename-echo -d 'Prints file name without extension'
    set_color normal

    set f $argv[1]
    if test -f "$f"
        set name (echo "$f" | sed 's/\.[^.]*$//')
        set ext (echo "$f" | sed 's/.*\.//')
        echo $name
        for i in (seq 1 100)
            set nf "$name "$i.$ext
            if test -f "$nf"
                echo "$name "$i
            else
                break;
            end
        end
    else
        set_color -o red
        echo 'File not found' $f
    end

    set_color normal
end
