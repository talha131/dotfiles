function tm_git_push -d 'Push to Git remote periodically'
    echo
    set attempt 1
    while true
       set a (git cherry -v)
       if test $a
           tm_printSuccess "Pushing new commits"
           set attempt (math $attempt - 1)
           git push
           echo
       else
           echo -en "\e[1A"
           echo -n "Waiting... "
           for i in (seq 1 10)
               sleep 1
               echo -n "$i "
           end
           tm_printMessage "Attempt  $attempt  : No new commits"
       end
       set attempt (math $attempt + 1)
   end
end
