function tm_split_path -d 'Return filename, ext, and directory from the path'
    set result (echo $argv[1] | gsed -n 's/\(.*\)\/\(.*\)\.\(.*\)$/\2\n\3\n\1/p')
    count $result > /dev/null
    # If arg does have path like /path/filename.ext
    and begin
        string join \n $result
    end
    # If arg does not have path like filename.ext
    or begin
        echo $argv[1] | gsed -n 's/\(.*\)\.\(.*\)$/\1\n\2/p'
    end
end
