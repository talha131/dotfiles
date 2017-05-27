# Open new iTerm and Terminal tabs from the command line
#
# USAGE
#
#   tab                   Opens the current directory in a new tab
#   tab [path]            Open PATH in a new tab
#   tab [cmd]             Open a new tab and execute CMD
#   tab [path] [cmd] ...  You can prolly guess
#
# If you use iTerm and your default session profile isn't "Default Session",
# override it in your `config.fish` or `omf/init.fish`
#
#     set -g tab_iterm_profile "MyProfile"
#
# AUTHOR
#
#   Justin Hileman (http://justinhileman.com)
#

function tab -d 'Open the current directory (or any other directory) in a new tab'
  set -l cmd ''
  set -l cdto $PWD

  if test (count $argv) -gt 0
    if test -d $argv[1]
      pushd . >/dev/null
      cd $argv[1]
      set cdto $PWD
      set -e argv[1]
      popd >/dev/null
    end
  end

  if test (count $argv) -gt 0
    set cmd "; $argv"
  end

  switch $TERM_PROGRAM

  case 'iTerm.app'
    if set -q tab_iterm_profile
      set profile $tab_iterm_profile
    else
      set profile "Default Session"
    end

    osascript 2>/dev/null -e "
      tell application \"iTerm\"
        tell current terminal
          launch session \"$profile\"
          tell the last session
            write text \"cd \\\"$cdto\\\"$cmd\"
          end tell
        end tell
      end tell
    "; or begin
      # Support for iTerm 2.9 beta:
      # - Handle new interface.
      # - New feature: open tab with default profile.

      if set -q tab_iterm_profile
        set profile "profile \"$tab_iterm_profile\""
      else
        set profile "default profile"
      end

      osascript 2>/dev/null -e "
        tell application \"iTerm\"
          tell current window
            set newTab to (create tab with $profile)
            tell current session of newTab
              write text \"cd \\\"$cdto\\\"$cmd\"
            end tell
          end tell
        end tell
      "
    end

  case 'Apple_Terminal'
    osascript 2>/dev/null -e "
      tell application \"Terminal\"
        activate
        tell application \"System Events\" to keystroke \"t\" using command down
        repeat while contents of selected tab of window 1 starts with linefeed
          delay 0.01
        end repeat
        do script \"cd \\\"$cdto\\\"$cmd\" in window 1
      end tell
    "

  case '*'
    echo "Unknown terminal: $TERM_PROGRAM" >&2
    return 1
  end
end
