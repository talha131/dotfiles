function op -d 'Open project layout in iTerm2'
  # sed is required because itermocil appends .yml to filename sent to it via fzf
  #
  # 2> and > slients all the output from itermocil. It prints help message if no filename is passed to it.
  # It happens when you do not select a file from fzf
  itermocil (ls ~/.itermocil/*.yml |  sed 's/\(.*\)\/\(.*\)\.\(.*\)$/\2/' | choose) 2> /dev/null > /dev/null
end
