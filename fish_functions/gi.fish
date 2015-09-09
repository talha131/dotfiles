# SYNOPSIS
#   gi templates
#   gi update
#
# DESCRIPTION
#   Simple CLI to gitignore.io to generate .gitignore files.
#
# LINKS
#   https://www.gitignore.io/

function gi::em;  set_color ff0    ; end
function gi::err; set_color f00    ; end
function gi::ok;  set_color 0f0    ; end
function gi::off; set_color normal ; end

function __gi_update_templates -a path
  if gi list | tr "," " " > $path
    printf "Templates downloaded to "(gi::ok)"$path"\n(gi::off)
  else
    echo \n(gi::err)"Error: Failed to retrieve templates."(gi::off) 1^&2
  end
end

function init -a path --on-event init_gi
  if not test -e $path/templates
    echo "Downloading "(gi::em)".gitignore"(gi::off)" templates... "
    __gi_update_templates $path/templates
  end
  complete --no-files -c gi -a "update" -d "Update Templates"
  complete --no-files -c gi -a (cat $path/templates)
end

function gi -d "gitignore.io CLI"
  if not set -q argv[1]
    echo "Usage:"
    echo "  gi "(gi::em)"templates"(gi::off)(gi::err)" > "(gi::off)".gitignore"
    echo "  gi "(gi::em)"update"(gi::off)
    return 0
  end
  switch $argv[1]
    case "-u" "update"
      __gi_update_templates
      return 0
  end
  curl -s "https://www.gitignore.io/api/"(printf ",%s" $argv | cut -c2-)
end
