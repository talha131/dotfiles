function tm_audio-mp3-bitrate
    for f in $argv
        set name (echo "$f" | sed 's/\.[^.]*$//')
        set ext (echo "$f" | sed 's/.*\.//')
        if test $ext = "mp3"
            set rate (ffprobe -v quiet -unit -prefix -print_format default  -select_streams a  -show_entries stream=bit_rate  046.mp3 | rg bit_rate | sed 's/bit_rate=//' | awk '{print $1}')
            tm_printSuccess "$rate $f"
        else
            tm_printMessage "Skipping $f"
        end
    end
    set_color normal
end




