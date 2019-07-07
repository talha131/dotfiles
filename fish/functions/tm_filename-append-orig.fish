function tm_filename-append-orig -d 'Append -orig to file name'
    for f in $argv
        set name (echo "$f" | sed 's/\.[^.]*$//')
        set ext (echo "$f" | sed 's/.*\.//')

        set nname (echo $name | sed 's/-orig//')
        if test "$name" = "$nname" && test -f $f
            set_color -o red
            mv -nv $f $name-orig.$ext
        else
            set_color yellow
            echo 'Skipping' $f
        end
        set_color normal
    end
end

