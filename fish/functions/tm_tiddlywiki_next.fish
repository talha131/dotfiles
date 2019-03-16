function tm_tiddlywiki_next -a 'port' -d 'Run tiddlywiki@next server. Default port=8081'
    set p = 8081
    if test -n "$port"
        set p = $argv[1]
    end
    ~/Repos/tiddlywiki/TiddlyWiki5/tiddlywiki.js --listen port=$p
end

