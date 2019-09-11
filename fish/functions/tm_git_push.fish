function tm_git_push -d 'Push to Git remote periodically'
    echo
    set attempt 1

    function _wait
           echo -en "\e[1A"
           echo -n "Waiting... "
           for i in (seq 1 10)
               sleep 1
               echo -n "$i "
           end
           tm_printMessage "Attempt  $attempt  : No new commits"
    end
    
    while true
       set a (git cherry -v)
       if test $status -ne 0
           tm_printWarning "git cherry failed" 
           echo
           beep
           _wait
       else 
           if test -n "$a"
               tm_printSuccess "Pushing new commits"
               set attempt (math $attempt - 1)
               git push
               or begin
                   tm_printWarning "git push failed" 
                   echo
                   beep
                   _wait
               end
               echo
           else
               _wait
               set attempt (math $attempt + 1)
           end
       end
    end
end
