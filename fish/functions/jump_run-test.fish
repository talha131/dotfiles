function jump_run-test -d 'Run a Golang test multiple times'
  set $_flag_count 20
  argparse 'n/count=' -- $argv
  or return

  # Print help
  if set --query _flag_help
    printf "Usage: jump_run-test [OPTIONS]\n\n"
    printf "Options:\n"
    printf "  -h/--help       Prints help and exits\n"
    printf "  -n/--count=NUM  Count (minimum 1, default 10)"
    return 0
  end

  set --query _flag_count; or set --local _flag_count 10

  for f in $argv
    # postive, negative
    set p 0
    set n 0

    tm_printMessage $f
    for i in (seq 1 $_flag_count)
      # print progress
      echo -n '.'

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
