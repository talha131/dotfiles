function tm_filename-prune-copysp -d 'Removes copy, s, p from file name'
    set p ~/"Downloads/VideoTitlesPNG"
    cd $p
    echo (pwd)

    for file in *.png
        set name (echo $file | sed 's/\.[^.]*$//')
        set ext (echo $file | sed 's/.*\.//')
        set copy (echo $name | sed 's/ copy$//')
        set sp (echo $copy | sed 's/ [p|s]$//')
        if [ $file != "$sp.$ext" ]
            set_color -o red
            mv -vn $file $sp.$ext
        end
    end

    set_color normal
    cd -
end

