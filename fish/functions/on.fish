function on -d 'Open a Neovim session'
  set folder "/Users/talha/Developer/VS Code Workspaces"
  set n (fd . -t f $folder | sed 's/.*\///' | choose)

  if test -f "$folder/$n"
    nvim -S "$folder/$n"
  end
end
