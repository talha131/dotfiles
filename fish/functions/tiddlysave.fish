function tiddlysave
    set p /Users/talha/Dropbox/TiddlyNotes/output/
    set f index.html

    set file "$p""$f"
    tm_tiddly-next ~/Dropbox/TiddlyNotes --verbose --build index

    if test -e "$file"
        set_color -o red
        echo "index.html found"
        
        set append (stat -f "%Sm" -t "%F-%H%M" "$file")
        set rootname (echo $f | sed 's/\.[^.]*$//')
        set ext (echo $file | sed 's/.*\.//')
        set new "$p""$rootname"-"$append"."$ext"

        set_color -o yellow
        echo "Rename $file → $new"
        set_color normal

        mv -v "$file" "$new"
    end
end
