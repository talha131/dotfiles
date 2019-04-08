function tm_filename-remove-orig -d 'Remove -orig from file name'
    for f in $argv
        set name (echo "$f" | sed 's/\.[^.]*$//')
        set ext (echo "$f" | sed 's/.*\.//')

        set nname (echo $name | sed 's/-orig//')
        if test "$name" != "$nname"
            set_color -o red
            mv -nv $f $nname.$ext
        else
            set_color yellow
            echo 'Skipping' $f
        end
        set_color normal
    end
end
