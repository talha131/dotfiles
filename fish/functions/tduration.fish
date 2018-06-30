function tduration
    for arg in $argv
        set_color -o red
        echo "$arg"
        set_color normal
        ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 -sexagesimal "$arg"
        ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$arg"
    end
end