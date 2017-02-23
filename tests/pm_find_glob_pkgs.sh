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
	info)
		shift
		pkg_info $@
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
	if [ "$1" == -g -a "$3" == "bash*" ]; then
		echo bash-4.4.12
		return 0
	fi
	if [ "$1" == -g -a "$3" == "libdvd*" ]; then
		echo libdvdcss-1.4.0_1
		echo libdvdnav-5.0.3
		echo libdvdread-5.0.3
		return 0
	fi
	if [ "$1" == -g -a "$3" == "asdf*" ]; then
		return 69
	fi
	/usr/sbin/pkg query $@
	return $?
}

pkg_info()
{
	if [ "$1" == -g -a "$2" == "bash*" ]; then
		echo bash-4.4.12
		return 0
	fi

	if [ "$1" == -g -a "$2" == "libdvd*" ]; then
		echo libdvdcss-1.4.0_1
		echo libdvdnav-5.0.3
		echo libdvdread-5.0.3
		return 0
	fi
	if [ "$1" == -g -a "$2" == "asdf*" ]; then
		return 70
	fi
	/usr/sbin/pkg info $@
	return $?
}

#test cases
test_pm_find_glob_pkgs()
{
	local rc
	pm_find_glob_pkgs bash
	rc=$?
	assertEquals "0" "$rc"
	assertEquals "bash-4.4.12" "$glob_pkgs"
}

test_pm_find_glob_pkgs_2()
{
	local rc
	pm_find_glob_pkgs libdvd
	rc=$?
	assertEquals "2" "$rc"
	set -- $glob_pkgs
	assertEquals "libdvdcss-1.4.0_1" "$1"
	assertEquals "libdvdnav-5.0.3" "$2"
	assertEquals "libdvdread-5.0.3" "$3"
}

test_pm_find_glob_pkgs_3()
{
	local rc
	pm_find_glob_pkgs asdf
	rc=$?
	assertEquals "1" "$rc"
	assertTrue "[ -z $glob_pkgs ]"
}

# loading shunit2
. ../shunit2/source/2.1/src/shunit2
