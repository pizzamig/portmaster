#!/bin/sh
. ../portmaster.subr

# test cases
test_pm_print()
{ # no verbosity - arrow
	local outstr
	outstr=$(pm_print ARR "Skipping gdb")
	assertEquals "===>>> Skipping gdb" "$outstr"
}

test_pm_print_2()
{ # verbosity - verb arrow
	PM_VERBOSE=vopt
	local outstr
	outstr=$(pm_print ARR VERB "Skipping gdb")
	assertEquals "===>>> Skipping gdb" "$outstr"
}

test_pm_print_3()
{ # no verbosity - verb arrow
	local outstr
	outstr=$(pm_print ARR VERB "Skipping gdb")
	assertEquals "" "$outstr"
}

test_pm_print_4()
{ # no verbosity - double indent
	local outstr
	outstr=$(pm_print DIND "because excluded")
	assertEquals '		because excluded' "$outstr"
}

test_pm_print_5()
{ # verbosity - verb double indent
	local outstr
	PM_VERBOSE=vopt
	outstr=$(pm_print VERB DIND "because excluded")
	assertEquals '		because excluded' "$outstr"
}

test_pm_print_6()
{ # verbosity - verb double indent
	local outstr
	outstr=$(pm_print VERB DIND "because excluded")
	assertEquals "" "$outstr"
}

setUp()
{
	unset PM_VERBOSE
}

# loading shunit2
. ../shunit2/source/2.1/src/shunit2
