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
}

# test cases
test_pm_get_origin()
{
	local rc origin
	origin=$(pm_get_origin bash-4.4.12)
	rc=$?
	assertEquals "2" "$rc"
	assertTrue "[ -z $origin ]"
}

test_pm_get_origin_2()
{
	local rc origin
	origin=$(pm_get_origin perl5-5.24.1)
	rc=$?
	assertEquals "0" "$rc"
	assertEquals "lang/perl5.24" "$origin"
}

test_pm_get_origin_3()
{
	local rc origin
	origin=$(pm_get_origin bsdpan-relics)
	rc=$?
	assertEquals "3" "$rc"
	assertTrue "[ -z $origin ]"
}

test_pm_get_origin_4()
{
	local rc origin
	origin=$(pm_get_origin asdf-3.4)
	rc=$?
	assertEquals "1" "$rc"
	assertTrue "[ -z $origin ]"
}

# loading shunit2
. ../shunit2/source/2.1/src/shunit2
