function tiddlysave
    # Default port
    # My default tiddlywiki
    set tw ~/Dropbox/TiddlyNotes
    argparse --name=tiddlysave 'h/help' -- $argv

    if test -n "$_flag_h"
        echo 'Save tiddlywiki'
        printf '\n'
        printf 'tiddlysave wikiname'
        printf '\n'
        echo $tw' is the default tiddlywiki'
        printf '\n'
        echo 'Example:'
        echo 'tiddlysave mynewwiki'
    else
        # Check if wiki path is given
        if test -n "$argv[1]"
            set tw "$argv[1]"
        end

        echo 'Tiddlywiki:' $tw

        tiddlywiki $tw --verbose --build index

        set p "/output/"
        set f "index.html"
        set file "$tw$p$f"
        tm_printMessage $file

        if test -e "$file"
            tm_printMessage "index.html found"
            
            set append (stat -f "%Sm" -t "%F-%H%M" "$file")
            set rootname (echo $f | sed 's/\.[^.]*$//')
            set ext (echo $file | sed 's/.*\.//')
            set new "$tw$p$rootname-$append.$ext"

            tm_printMessage "Rename $file → $new"
            mv -v "$file" "$new"
        end
    end
end
