function tm_bm_image -d 'Resize image'
  set convertFile (gdate +"%Y-%m-%d %H%m%S %N-convert.txt")
  set uploadFile (gdate +"%Y-%m-%d %H%m%S %N-upload.txt")
  set moveFile (gdate +"%Y-%m-%d %H%m%S %N-move.txt")

  for f in $argv

    test -f $f
    and begin
      tm_printMessage "Processing $f"
      set fep (tm_split_path $f)
      set name $fep[1]
      set ext $fep[2]

      test "$ext" = "png"
      and begin
        tm_printMessage "Size of $f"
        identify $f
        set nf (echo "$name-orig.$ext")
        tm_printMessage "Rename $f to $nf"
        mv -v $f $nf

        echo "convert \"$nf\" -resize 1920x1080 \"$name.png\"" >> $convertFile
        echo "convert \"$nf\" -resize 1920x1080 \"$name.jpg\"" >> $convertFile
        echo "rclone copy \"$nf\" pcloud:\"Project - Podcast Archives/A4 Published Backgrounds\" -P" >> $uploadFile
        echo "rclone copy \"$name\".png pcloud:\"Project - Podcast Archives/A4 Published Backgrounds\" -P" >> $uploadFile
        echo "mv -v \"$name\".png \"/Users/talha/Documents/BM Playground/video-titles-png/\"" >> $moveFile
      end
      or begin
        tm_printWarning "$f is not png"
      end
    end
    or begin
      tm_printWarning "$f does not exist"
    end
  end

  tm_printMessage "Resize files"
  parallel --jobs 4 < $convertFile
  and begin
    trash $convertFile
    tm_printMessage "Copy to cloud"
    parallel --jobs 4 < $uploadFile
    and begin
      trash $uploadFile
      tm_printMessage "Move to video titles folder"
      mkdir -p "/Users/talha/Documents/BM Playground/video-titles-png/"
      parallel --jobs 4 < $moveFile
      trash $moveFile
    end
    or begin
      tm_printWarning "Upload to cloud failed"
    end
  end
  or begin
    tm_printWarning "Convert failed"
  end

end
