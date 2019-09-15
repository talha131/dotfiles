function beep
    echo -n \a
end

function beepPreviousLine
    echo -en "\e[1A\a"
end
