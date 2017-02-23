#!/bin/sh
. ../portmaster.subr

test_pm_globstrip()
{
	assertEquals "bash" "$(pm_globstrip bash)"
	assertEquals "bash" "$(pm_globstrip bash\*)"
	assertEquals "bash" "$(pm_globstrip 'bash\')"
	assertEquals "bash" "$(pm_globstrip 'bash*')"
}

# loading shunit2
. ../shunit2/source/2.1/src/shunit2
