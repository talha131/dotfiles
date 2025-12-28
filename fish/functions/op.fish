function op -d 'Open project layout in iTerm2'
  # 2> and > silences all the output from itermocil. It prints help message if no filename is passed to it.
  # It happens when you do not select a file from fzf
  itermocil (itermocil --list | tail -n +2 | string trim | choose) 2> /dev/null > /dev/null
end
