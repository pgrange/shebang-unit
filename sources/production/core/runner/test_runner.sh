function test_runner__run_test() {
	local test_function=$1
	shift 1
  reporter__test_starts_running "${test_function}"
	(
	  _test_runner__call_setup_if_exists "$@" \
	  && ( ${test_function} )
	  local setup_and_test_code=$?
	  _test_runner__call_teardown_if_exists "$@"
	  (( $? == ${SBU_SUCCESS_STATUS_CODE} \
	  &&  ${setup_and_test_code} == ${SBU_SUCCESS_STATUS_CODE} ))
	)
	_test_runner__parse_test_function_result $?
}

function _test_runner__call_setup_if_exists() {
  _test_runner__call_function_if_exits "${SBU_SETUP_FUNCTION_NAME}" "$@"
}

function _test_runner__call_teardown_if_exists() {
  _test_runner__call_function_if_exits "${SBU_TEARDOWN_FUNCTION_NAME}" "$@"
}

function _test_runner__parse_test_function_result() {
	if (( $1 == ${SBU_SUCCESS_STATUS_CODE} )); then
		(( global_green_tests_count++ ))
		reporter__test_has_succeeded
	else
		(( global_red_tests_count++ ))
		reporter__test_has_failed
	fi
}

function _test_runner__call_function_if_exits() {
	local function=$1
	shift 1
	if system__array_contains "${function}" "$@"; then
	  "${function}"
	fi
}