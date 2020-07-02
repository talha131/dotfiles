function op -d 'Open project layout in iTerm2'
  itermocil (ls ~/.itermocil/*.yml |  sed 's/\(.*\)\/\(.*\)\.\(.*\)$/\2/' | fzf) 2> /dev/null > /dev/null
end
