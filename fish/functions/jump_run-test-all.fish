function jump_run-test-all -d 'Run all Golang tests'

  # create temp dir
  set temp (gmktemp -d)
  echo $temp

  tm_printMessage "Running tests first time"
  go test --run Test | rg FAIL: | sed 's/^--- FAIL: //' | sed 's/ ([[:digit:]]*.[[:digit:]]*s)//' > $temp/failed_tests_0.txt

  if test (wc -l < $temp/failed_tests_0.txt) -eq 0
    tm_printSuccess "All tests passed"
    trash -v $temp
    return 0
  end

  tm_printWarning "Some tests failed"
  tm_printMessage "Running tests second time"

  # Join all lines into one line
  # The output is a regex like this:
  # TestABC | TestDEF | TestGHI
  set tests (cat $temp/failed_tests_0.txt | tr '\n' '|' | sed 's/|$//')

  # Run tests
  go test --run $tests | rg FAIL: | sed 's/^--- FAIL: //' | sed 's/ ([[:digit:]]*.[[:digit:]]*s)//' > $temp/failed_tests_1.txt

  sort $temp/failed_tests_1.txt > $temp/failed_tests_1_sorted.txt

  if test (wc -l < $temp/failed_tests_1_sorted.txt) -eq 0
    tm_printSuccess "All tests passed"
  else
    tm_printWarning "Tests that failed both times"
    cat failed_tests_1_sorted.txt
  end

  trash -v $temp
end
