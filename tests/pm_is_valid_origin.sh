#!/bin/sh
. ../portmaster.subr

# test cases
test_pm_is_valid_origin()
{
	local rc 
	pm_is_valid_origin devel/normal
	rc=$?
	assertEquals "$PM_TRUE" "$rc"
	pm_is_valid_origin devel/broken
	rc=$?
	assertEquals "$PM_TRUE" "$rc"
	pm_is_valid_origin devel/forbidden
	rc=$?
	assertEquals "$PM_TRUE" "$rc"
}

test_pm_is_valid_origin_2()
{ # backup succeeded
	local rc 
	pm_is_valid_origin
	rc=$?
	assertEquals "$PM_FALSE" "$rc"
	pm_is_valid_origin devel/noport
	rc=$?
	assertEquals "$PM_FALSE" "$rc"
}

test_pm_is_valid_origin_3()
{ # backup not succeeded
	local rc 
	pm_is_valid_origin nocat
	rc=$?
	assertEquals "$PM_FALSE" "$rc"
}

setUp()
{
	pd=faketree
}

# loading shunit2
. ../shunit2/source/2.1/src/shunit2
