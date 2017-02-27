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
	if [ "$2" == "hsetroot-1.0.2" ]; then
		echo graphics/hsetroot
		return 0
	fi
	if [ "$2" == "samba4wins-4.0.2" ]; then
		echo net/samba4wins
		return 0
	fi
	if [ "$2" == "foobar-3.4" ]; then
		echo test/foobar
		return 0
	fi
	/usr/sbin/pkg query $@
	return $?
}

[() {
	if /bin/test "$1" = "-e" -a "$2" = "$pdb/bash-4.4.12/+IGNOREME" ; then
		return 0 # true
	fi
	if /bin/test "$1" = "-d" -a "$2" = "$pd/lang/perl5.24" ; then
		return 0 # true
	fi
	if /bin/test "$1" = "-d" -a "$2" = "$pd/graphics/hsetroot" ; then
		return 1 # false
	fi
	if /bin/test "$1" = "-d" -a "$2" = "$pd/net/samba4wins" ; then
		return 1 # false
	fi
	if /bin/test "$1" = "-d" -a "$2" = "$pd/test/foobar" ; then
		return 1 # false
	fi
	/bin/[ "$@"
}

# test cases
test_pm_get_moved_origin()
{ # port with +IGNOREME
	local rc origin
	origin=$(pm_get_moved_origin bash-4.4.12)
	rc=$?
	assertEquals "2" "$rc"
	assertTrue "[ -z $origin ]"
}

test_pm_get_moved_origin_2()
{ # regular port
	local rc origin
	origin=$(pm_get_moved_origin perl5-5.24.1)
	rc=$?
	assertEquals "0" "$rc"
	assertEquals "lang/perl5.24" "$origin"
}

test_pm_get_moved_origin_3()
{ # bsdpan- port
	local rc origin
	origin=$(pm_get_moved_origin bsdpan-relics)
	rc=$?
	assertEquals "3" "$rc"
	assertTrue "[ -z $origin ]"
}

test_pm_get_moved_origin_4()
{ # not existing port
	local rc origin
	origin=$(pm_get_moved_origin asdf-3.4)
	rc=$?
	assertEquals "1" "$rc"
	assertTrue "[ -z $origin ]"
}

test_pm_get_moved_origin_5()
{ # regular port but moved
	local rc origin
	origin=$(pm_get_moved_origin hsetroot-1.0.2)
	rc=$?
	assertEquals "0" "$rc"
	assertEquals "x11/hsetroot" "$origin"
}

test_pm_get_moved_origin_6()
{ # port removed
	local rc origin
	origin=$(pm_get_moved_origin samba4wins-4.0.2)
	rc=$?
	assertEquals "5" "$rc"
	assertTrue "[ -z $origin ]"
}

test_pm_get_moved_origin_7()
{ # port not moved and not found
	local rc origin
	origin=$(pm_get_moved_origin foobar-3.4)
	rc=$?
	assertEquals "4" "$rc"
	assertTrue "[ -z $origin ]"
}

setUp()
{
	pd=./
}

# loading shunit2
. ../shunit2/source/2.1/src/shunit2
