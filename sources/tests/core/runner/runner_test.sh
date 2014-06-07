function setup() {
  results__tests_files_start_running
}

function tests_are_successful_if_no_failure_and_no_test_not_run() {
  assertion__successful runner__tests_are_successful
}

function tests_arent_successful_if_there_are_failures() {
  results__increment_failing_tests

  assertion__failing runner__tests_are_successful
}

function tests_arent_successful_if_there_are_tests_not_fun() {
  results__increment_not_run_tests

  assertion__failing runner__tests_are_successful
}