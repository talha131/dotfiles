function tm_bm_audio_image_to_mp4 -d 'Combine audio m4a file with PNG image to make mp4 video'

    set rfile (gdate +"%Y-%m-%d %H%m%S %N.txt")
    set dname (gdate +"%Y-%m-%d %H%m%S output mp4")

    for f in $argv/*
        set fep (tm_split_path $f)
        set name $fep[1]
        set ext $fep[2]
        set image (echo "/Users/talha/Documents/BM Playground/video-titles-png/$name.png")

        if test -f $f
            if test "$ext" = "m4a"
                if test -f $image
                    echo "ffmpeg -loop 1 -i \"$image\" -i \"$f\" -vf \"scale='min(1280,iw)':-2,format=yuv420p\" -c:v libx264 -preset veryslow -profile:v main -level 4.1 -c:a aac -shortest -fflags +shortest -max_interleave_delta 0 -movflags +faststart \"$dname/$name.mp4\"" >> $rfile

                else
                    tm_printWarning "$image not found for $f"
                end
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

      # Check output length
      for f in $argv/*
        set fep (tm_split_path $f)
        set name $fep[1]
        set ext $fep[2]

        if test -f $f
          if test "$ext" = "m4a"
            if test -f $image
              tm_printMessage "Length of $f (audio, video)"
              ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 -sexagesimal $f
              ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 -sexagesimal $dname/$name.mp4
            end
          end
        end
      end

    else 
      tm_printWarning "$rfile is missing. No conversion"
    end
end
