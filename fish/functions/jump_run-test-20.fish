function jump_run-test-20 -d 'Run a Golang test 20 times'
  for f in $argv
    set times 20
    # postive, negative
    set p 0
    set n 0

    tm_printMessage $f
    for i in (seq 1 $times)
      # print progress
      echo -n '#'

      go test -p 1 --run $f > /dev/null
      and begin
        set p (math $p + 1)
      end
      or begin
        set n (math $n + 1)
      end
    end

    # erase progress
    echo -e "\e[2K\e[0F"

    if test $p -gt 0
      tm_printSuccess "Positive: $p Negative: $n"
    else
      tm_printWarning "Positive: $p Negative: $n"
    end
  end
end
