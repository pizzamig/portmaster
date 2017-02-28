#!/bin/sh
. ../portmaster.subr

pkg()
{
	case $1 in
	create)
		shift
		pkg_create $@
		return $?
		;;
	*)
		/usr/sbin/pkg $@
		return $?
	esac
}

# pkg subcommand stub
pkg_create()
{
	if [ "$1" = "--out-dir" ]; then
		if [ "$3" = "perl5-5.24.1" ]; then
			return 0 # true
		else
			return 1 # false
		fi
	fi
	/usr/sbin/pkg query $@
	return $?
}

[() {
	if /bin/test "$1" = "!" -a "$2" = "-d" -a "$3" = "${PACKAGES}/portmaster-backup" ; then
		return 1 # false
	fi
	/bin/[ "$@"
}

# test cases
test_pm_backup()
{ # NO_BACKUP
	local rc 
	NO_BACKUP=nbkp
	pm_backup bash-4.4.12
	rc=$?
	assertEquals "$PM_TRUE" "$rc"
	unset NO_BACKUP
}

test_pm_backup_2()
{ # backup succeeded
	local rc 
	pm_backup perl5-5.24.1
	rc=$?
	assertEquals "$PM_TRUE" "$rc"
}

test_pm_backup_3()
{ # backup not succeeded
	local rc 
	pm_backup bash-4.4.12
	rc=$?
	assertEquals "$PM_FALSE" "$rc"
}

setUp()
{
	PACKAGES=/usr/ports/packages
}

# loading shunit2
. ../shunit2/source/2.1/src/shunit2
