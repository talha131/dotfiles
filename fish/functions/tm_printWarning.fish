function tm_printWarning
    for arg in $argv
        set_color -o red
        echo '⚠️   '$arg
    end
    set_color normal
end



