function tiddlytemp -d "Create temporary TiddlyWiki"
   set temp (gmktemp -d)
   set port 9999
   tiddlywiki $temp/temp --init server
   and begin
       tm_printMessage "Created temporary TiddlyWiki at $temp"
       open http://127.0.0.1:$port
       tiddlywiki $temp/temp --listen port=$port
       tm_printMessage "Clean up $temp"
       trash -rf $temp
   end
end
