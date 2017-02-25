#!/bin/sh
. ../portmaster.subr

pkg()
{
	case $1 in
	query)
		shift
		pkg_query $@
		return $?
		;;
	*)
		/usr/sbin/pkg $@
		return $?
	esac
}

# pkg subcommand stub
pkg_query()
{
	if [ "$2" == "perl5-5.24.1" ]; then
		echo lang/perl5.24
		return 0
	fi
	/usr/sbin/pkg query $@
	return $?
}

[() {
	if /bin/test "$1" = "-e" -a "$2" = "$pdb/bash-4.4.12/+IGNOREME" ; then
		return 0 # true
	fi
	/bin/[ "$@"
} # ];]

# test cases 
test_pm_find_moved_origin()
{ # port not moved
	local rc origin
	origin=$(pm_find_moved_origin shells/bash)
	rc=$?
	assertEquals "0" "$rc"
	assertTrue "[ -z $origin ]"
}

test_pm_find_moved_origin_2()
{ # port moved
	local rc origin
	origin=$(pm_find_moved_origin graphics/hsetroot)
	rc=$?
	assertEquals "1" "$rc"
	assertEquals "x11/hsetroot" "$origin"
}

test_pm_find_moved_origin_3()
{ # port removed
	local rc reason
	reason=$(pm_find_moved_origin net/samba4wins)
	rc=$?
	assertEquals "2" "$rc"
	assertEquals "Not staged" "$reason"
}

test_pm_find_moved_origin_4()
{ # port moved twice
	local rc origin
	origin=$(pm_find_moved_origin test/foo)
	rc=$?
	assertEquals "1" "$rc"
	assertEquals "test/foo3" "$origin"
}

test_pm_find_moved_origin_5()
{ # port moved and then removed
	local rc reason
	reason=$(pm_find_moved_origin test/bar)
	rc=$?
	assertEquals "2" "$rc"
	assertEquals "Has been deleted" "$reason"
}

setUp()
{
	pd=./
}

# loading shunit2
. ../shunit2/source/2.1/src/shunit2
