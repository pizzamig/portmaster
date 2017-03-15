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
	local state
	state=$(pm_get_port_sanity_state devel/forbidden)
	assertEquals "FORBIDDEN" "$state"
}

test_pm_get_port_sanity_state_3()
{ # IGNORE port
	local state
	state=$(pm_get_port_sanity_state devel/ignore)
	assertEquals "IGNORE" "$state"
}

test_pm_get_port_sanity_state_4()
{ # sane port
	local state
	state=$(pm_get_port_sanity_state devel/normal)
	assertNull "" "$state"
}

setUp()
{
	pd=./faketree
}

# loading shunit2
. ../shunit2/source/2.1/src/shunit2
