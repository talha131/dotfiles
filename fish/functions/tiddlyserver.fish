function tiddlyserver -d 'Run tiddlywiki server'
    # Default port
    set _flag_p 8089
    # My default tiddlywiki
    set tw ~/Dropbox/TiddlyNotes
    argparse --name=tiddlyserver 'h/help' 'p/port=' -- $argv

    if test -n "$_flag_h"
        echo 'Run tiddlywiki server'
        printf '\n'
        printf 'tiddlyserver wikiname --port [8000]\n'
        printf '\n'
        echo $tw' is the default tiddlywiki'
        echo 'Default port is '$_flag_p
        echo 'Use --port or -p to specify custom port'
        printf '\n'
        echo 'Example:'
        echo 'tiddlyserver mynewwiki --port 8081'
    else
        # Check if wiki path is given
        if test -n "$argv[1]"
            set tw "$argv[1]"
        end

        echo 'Port:' $_flag_p
        echo 'Tiddlywiki:' $tw

        tiddlywiki $tw --listen port=$_flag_p root-tiddler=\$:/core/save/lazy-images
    end
end
