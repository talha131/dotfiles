function tm_split_path -d 'Return filename, ext, and directory from the path'
    echo $argv[1] | gsed 's/\(.*\)\/\(.*\)\.\(.*\)$/\2\n\3\n\1/'
end
