function tiddlyserver -d 'Run tiddlywiki server'
    # Default port
    set _flag_p 8089
    set _flag_i 127.0.0.1
    # My default tiddlywiki
    set tw ~/Dropbox/TiddlyNotes
    argparse --name=tiddlyserver 'h/help' 'i/host=' 'p/port=' -- $argv

    if test -n "$_flag_h"
        echo 'Run tiddlywiki server'
        printf '\n'
        printf 'tiddlyserver wikiname --port [8000]\n'
        printf '\n'
        echo $tw' is the default tiddlywiki'
        echo 'Default host is '$_flag_i
        echo 'Use --host or -i to specify custom port'
        printf '\n'
        echo 'Default port is '$_flag_p
        echo 'Use --port or -p to specify custom port'
        printf '\n'
        echo 'Example:'
        echo 'tiddlyserver mynewwiki --host 192.168.10.112 --port 8081'
    else
        # Check if wiki path is given
        if test -n "$argv[1]"
            set tw "$argv[1]"
        end

        echo 'Host:' $_flag_i
        echo 'Port:' $_flag_p
        echo 'Tiddlywiki:' $tw

        tiddlywiki $tw --listen host=$_flag_i port=$_flag_p root-tiddler=\$:/core/save/lazy-images
    end
end
