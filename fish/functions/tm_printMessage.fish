function tm_printMessage
    for arg in $argv
        set_color -o yellow
        echo '📌  '$arg
    end
    set_color normal
end


