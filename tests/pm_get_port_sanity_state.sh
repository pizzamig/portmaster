#!/bin/sh
. ../portmaster.subr

# test cases
test_pm_get_port_sanity_state()
{ # BROKEN case
	local state _cwd
	_cwd=$(pwd)
	state=$(pm_get_port_sanity_state devel/broken)
	assertEquals "BROKEN" "$state"
	assertEquals "$_cwd" "$(pwd)"
}

test_pm_get_port_sanity_state_2()
{ # FORBIDDEN port
	local state _cwd
	_cwd=$(pwd)
	state=$(pm_get_port_sanity_state devel/forbidden)
	assertEquals "FORBIDDEN" "$state"
	assertEquals "$_cwd" "$(pwd)"
}

test_pm_get_port_sanity_state_3()
{ # IGNORE port
	local state _cwd
	_cwd=$(pwd)
	state=$(pm_get_port_sanity_state devel/ignore)
	assertEquals "IGNORE" "$state"
	assertEquals "$_cwd" "$(pwd)"
}

test_pm_get_port_sanity_state_4()
{ # sane port
	local state _cwd
	_cwd=$(pwd)
	state=$(pm_get_port_sanity_state devel/normal)
	assertNull "" "$state"
	assertEquals "$_cwd" "$(pwd)"
}

test_pm_get_port_sanity_state_5()
{ # broken port, no argument
	local state _cwd
	_cwd=$(pwd)
	cd faketree/devel/broken
	state=$(pm_get_port_sanity_state)
	assertEquals "BROKEN" "$state"
	assertEquals "$_cwd/faketree/devel/broken" "$(pwd)"
	cd $_cwd
}

test_pm_get_port_sanity_state_6()
{ # ignore port, no argument
	_cwd=$(pwd)
	cd faketree/devel/ignore
	if [ -z "$(pm_get_port_sanity_state)" ]; then
		fail "IGNORE not recognized"
	fi
	cd $_cwd
}

test_pm_get_port_sanity_state_7()
{ # sane port, no argument
	_cwd=$(pwd)
	cd faketree/devel/normal
	if [ -n "$(pm_get_port_sanity_state)" ]; then
		fail "sane port not recognized - $(pm_get_port_sanity_state)"
	fi
	cd $_cwd
}

setUp()
{
	pd=./faketree
}

# loading shunit2
. ../shunit2/source/2.1/src/shunit2
