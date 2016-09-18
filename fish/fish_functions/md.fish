function md -d "Create a directory and set CWD. If the directory already exists then set CWD"
    set i (count $argv)
    if math "$i == 1" > /dev/null; and test -d $argv
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
