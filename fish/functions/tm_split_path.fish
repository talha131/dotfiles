# Examples:
#   tm_split_path /Users/talha/video.mp4
#   # Output:
#   # video
#   # mp4
#   # Users/talha
#
#   tm_split_path document.pdf
#   # Output:
#   # document
#   # pdf
#
#   set parts (tm_split_path /path/to/file.txt)
#   echo $parts[1]  # file
#   echo $parts[2]  # txt
#   echo $parts[3]  # path/to

function tm_split_path -d 'Return filename, ext, and directory from the path'
    set -l path $argv[1]
    set -l dir (string match -r '.+/' $path | string trim -c /)
    set -l base (basename $path)
    
    string replace -r '\.[^.]+$' '' $base  # filename without ext
    string match -r '[^.]+$' $base          # extension only
    test -n "$dir" && echo $dir             # directory (if exists)
end