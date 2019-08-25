function tm_split_path -d 'Take path and return filename, ext and path'
    set f $argv[1]
    set name (echo $f | sed 's/.*\/\(.*\)\..*$/\1/')
    set ext (echo $f | sed 's/.*\.//')
	set pth (echo $f | sed 's/\(.*\)\/.*/\1/')
	echo $name 
	echo $ext 
	echo $pth
end
