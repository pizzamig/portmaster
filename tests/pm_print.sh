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

test_pm_print_arr()
{
	local outstr arg
	arg="devel/gdb"
	outstr=$(pm_print_arr "Skipping $arg")
	assertEquals "===>>> Skipping devel/gdb" "$outstr"
}

test_pm_print_arr_2()
{
	local outstr arg
	arg="devel/gdb"
	outstr=$(pm_print_arr VERB "Skipping $arg")
	assertEquals "" "$outstr"
	PM_VERBOSE=vopt
	outstr=$(pm_print_arr VERB "Skipping $arg")
	assertEquals "===>>> Skipping devel/gdb" "$outstr"
}

test_pm_print_verb()
{
	local outstr arg
	PM_VERBOSE=vopt
	arg="devel/gdb"
	outstr=$(pm_print_verb "Skipping $arg")
	assertEquals "Skipping devel/gdb" "$outstr"
}

test_pm_print_verb_2()
{
	local outstr arg
	PM_VERBOSE=vopt
	arg="devel/gdb"
	outstr=$(pm_print_verb DIND "Skipping $arg")
	assertEquals "		Skipping devel/gdb" "$outstr"
}

test_pm_print_verb_3()
{
	local outstr arg
	arg="devel/gdb"
	outstr=$(pm_print_verb DIND "Skipping $arg")
	assertEquals "" "$outstr"
}

setUp()
{
	unset PM_VERBOSE
}

# loading shunit2
. ../shunit2/source/2.1/src/shunit2
