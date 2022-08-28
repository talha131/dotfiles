function pcloud-upload -d 'Upload file to fish'
    argparse h/help s/second -- $argv
    or return

    set root "Public Folder"
    set name archive
    set i 0
    set count 0
    set limit 200

    function _pcloud_upload_create_index_files -S
        if not test -d ~/.local/share/tm-pcloud
            tm_printMessage "Create files to store index and count"
            mkdir ~/.local/share/tm-pcloud
        end
        touch ~/.local/share/tm-pcloud/current
        touch ~/.local/share/tm-pcloud/count
    end

    function _pcloud_upload_set_index_files -S
        set cur (bat -p -r 1 ~/.local/share/tm-pcloud/current)
        if test -z $cur; or not test $cur -ge 0
            echo -n $i > ~/.local/share/tm-pcloud/current
        else 
            set i $cur
        end

        set count (bat -p -r 1 ~/.local/share/tm-pcloud/count)
        if test -z $count; or not test $count -ge 0
            _pcloud_upload_update_file_count
        end
    end

    function _pcloud_upload_update_file_count -S
        # create direcotry which might be missing when index is incremented
        rclone mkdir pcloud:"$root/$name-$i"
        set count (rclone size --json pcloud:"$root/$name-$i" | sed -rn 's/.*count":([0-9]+).*/\1/p')
        echo -n $count > ~/.local/share/tm-pcloud/count
    end

    function _pcloud_upload_move_file -S -a f
        if test -e $f
            # get file name parts
            set count (math $count + 1)
            set file (tm_split_path $f)
            # move file
            rclone moveto "$f" pcloud:"$root/$name-$i/$count-$file[1].$file[2]" -P
            if test $status -eq 0
                tm_printSuccess "$f uploaded"
                set url "https://filedn.com/laUTmcj57lPkQfIaVW9b29L/$name-$i/$count-$file[1].$file[2]"
                # do not output a new line
                echo -n $url | pbcopy
                echo $url
                echo -n $count > ~/.local/share/tm-pcloud/count
            else
                tm_printWarning "$f upload failed"
            end
        else
            tm_printWarning "$f does not exist"
        end
    end

    # main
    _pcloud_upload_create_index_files
    _pcloud_upload_set_index_files

    while test $count -ge $limit
        tm_printMessage "$count files already present in index $i"
        set i (math $i + 1)
        echo -n $i > ~/.local/share/tm-pcloud/current
        tm_printMessage "Try dir index $i"
        _pcloud_upload_update_file_count
    end

    tm_printMessage "Dir index is $i"
    tm_printMessage "File count is $count"

    for f in $argv
        _pcloud_upload_move_file "$f"
    end

    tm_printMessage "Final file count is $count"

    # if terminal is iTerm2
    it2check
    if test $status -eq 0
        it2attention fireworks
    end

    functions -e _pcloud_upload_create_index_files
    functions -e _pcloud_upload_set_index_files
    functions -e _pcloud_upload_update_file_count
    functions -e _pcloud_upload_move_file
end
