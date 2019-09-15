function tm_git_push -d 'Push to Git remote periodically'
    echo
    set -g attempt 1

    function _wait
           echo -en "\e[1A"
           echo -n "Waiting... "
           for i in (seq 1 10)
               sleep 1
               echo -n "$i "
           end
    end
    
    while true
       git cherry > /dev/null 2> /dev/null
       # git cherry is successful
       and begin
           # Check if there are unpushed commits 
           count (git cherry) > /dev/null
           # there are unpushed commits
           and begin
               git push > /dev/null 2> /dev/null
               and begin 
                   tm_printSuccess "Pushing new commits"
               end
               # git push failed
               or begin
                   _wait
                   tm_printWarning "git push failed" 
                   beepPreviousLine
               end
               echo
           end
           # there are no unpushed commits
           or begin
               _wait
               tm_printMessage " Attempt $attempt : No new commits"
               set attempt (math $attempt + 1)
           end
       end
       # git cherry fails
       or begin
           _wait
           tm_printWarning "git cherry failed" 
           beepPreviousLine
       end
    end
end
