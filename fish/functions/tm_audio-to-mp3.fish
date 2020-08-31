function tm_audio-to-mp3 -d 'Convert wav/mp3 file to a lower bitrate mp3'

    set rfile (gdate +"%Y-%m-%d %H%m%S %N.txt")
    set dname (gdate +"%Y-%m-%d %H%m%S output mp3")

    for f in $argv/*
        set fep (tm_split_path $f)
        set name $fep[1]
        set ext $fep[2]

        if test -f $f
            if test "$ext" = "mp3" || test "$ext" = "wav"
                echo "ffmpeg -i \"$f\" -ac 1 -ar 44100 -b:a 32k \"$dname/$name.mp3\"" >> $rfile
            end
        end
    end

    if test -f $rfile
      set count (wc -l $rfile | awk '{print $1}')
      if test $count != "0"
          tm_printMessage "Convert $count files"
          set start (gdate +%s)
          mkdir $dname
          tm_printMessage "Conversion started"
          parallel --jobs 4 < $rfile
          set end (gdate +%s)
          set elappsed (math $end - $start)
          tm_printMessage "Converted $count files in $elappsed seconds"
          open $dname
      end

      tm_printMessage "Removing $rfile"
      trash $rfile
    else
      tm_printWarning "$rfile not found"
    end
end

