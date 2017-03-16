#!/bin/sh
. ../portmaster.subr

# test cases
test_pm_check_exclude()
{ # standard case - libreoffice and py-salt
	local rc
	pm_check_for_exclude libreoffice
	rc=$?
	assertEquals "$PM_FALSE" "$rc"
	pm_check_for_exclude py-salt
	rc=$?
	assertEquals "$PM_FALSE" "$rc"
}

test_pm_check_exclude_2()
{ # not excluded port
	local rc
	pm_check_for_exclude llvm39
	rc=$?
	assertEquals "$PM_TRUE" "$rc"
}

test_pm_check_exclude_3()
{ # no exclude
	unset PM_EXCL
	local rc
	pm_check_for_exclude libreoffice
	rc=$?
	assertEquals "$PM_TRUE" "$rc"
	pm_check_for_exclude py-salt
	rc=$?
	assertEquals "$PM_TRUE" "$rc"
	pm_check_for_exclude llvm39
	rc=$?
	assertEquals "$PM_TRUE" "$rc"
}

setUp()
{
	PM_EXCL="libre llvm38 salt"
}

# loading shunit2
. ../shunit2/source/2.1/src/shunit2
