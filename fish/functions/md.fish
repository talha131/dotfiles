function md -d "Create a directory and set CWD. If the directory already exists then set CWD"
    set i (count $argv)
    if test $i -eq 1; and test -d $argv
        cd $argv
    else
        command mkdir -p $argv
        if test $status = 0
            switch $argv[(count $argv)]
                case '-*'

                case '*'
                    cd $argv[(count $argv)]
                    return
            end
        end
    end
end
