function tm_bm_upload_audio -d 'Upload audio files from IC Recorder to pCloud'
    set root "/Volumes/IC RECORDER"
    if test (count $argv) -ge 1
        set root $argv[1]
    end

    function _createTempDir
        set temp "/Users/talha/Downloads/"(gdate +%Y-%m-%d-%H%M%S%N)
        test -d $temp
        and begin
            tm_printWarning "Temp Directory $temp alredy exist"
            beep
            return 1
        end
        or begin
            mkdir $temp && echo $temp && return 0
        end
    end

    test -d $root
    and begin
        tm_printMessage "Folder $root found"
        # Remove lock from the file
        fd capability_01.xml $root -x chflags nouchg
        fd capability_01.xml $root -X trash \{\} 
        fd MSGLISTL.MSF $root -X trash \{\}
        fd . -t e $root -X trash \{\}
        set t (_createTempDir)
        and begin
            tm_printMessage "Copy files to $t"
            fd . -e mp3 $root -X cp -pv \{\} $t
            tm_printMessage "Rename files to their birth time"
            for i in $t/*.{mp3,MP3}
               mv -vn $i $t/(gdate -d (stat -f "%SB" $i) "+%Y-%m-%d %H%M%S-orig.mp3")
            end
            tm_printMessage "Upload files to the pcloud"
            rclone move $t pcloud:"Project - Podcast Archives/A0 Friday Lectures - Raw Files - Todo" -P --delete-empty-src-dirs
            and begin
                fd . $t | read
                and begin
                    tm_printWarning "Directory $t is not empty"
                    open $t
                end
                or begin
                    tm_printMessage "Remove $t"
                    trash $t
                end
            end
            or begin 
                tm_printWarning "Failed to moves files to pcloud"
            end 
        end
        or begin 
            tm_printWarning "Failed to create a temp folder"
        end 
    end
    or begin
        tm_printWarning "Folder $root missing"
    end
end

