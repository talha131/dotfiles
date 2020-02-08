function tm_filename-prepend-string -d 'Prepend a string to files names'
    # example
    # tm_filename-prepend-string * -s "2018-02-09 130916"
    argparse --name=tm_filename-prepend-string 's/str=' -- $argv
	or return

    for f in $argv
        set name (echo "$f" | sed 's/\.[^.]*$//')
        set ext (echo "$f" | sed 's/.*\.//')

		set leftover (echo $name | sed 's/^[[:digit:]]*//')

		if test -z "$leftover" && test -n "$_flag_s" 
            set_color -o red
			mv -nv $f "$_flag_s $name".$ext 
		else
            set_color yellow
            echo 'Skipping' $f
        end

        set_color normal
    end
end

