#!/bin/sh
. ../portmaster.subr

# test cases
test_pmlist_is_present()
{
	local rc
	TESTLIST="asdf:blah:foo"
	PMLIST_NAME=TESTLIST
	if ! pmlist_is_present asdf ; then
		fail "First element not detected"
	fi
	if ! pmlist_is_present blah ; then
		fail "Middle element not detected"
	fi
	if ! pmlist_is_present foo ; then
		fail "Last element not detected"
	fi
	if pmlist_is_present foobar ; then
		fail "Random element detected"
	fi
}

test_pmlist_is_present_2()
{
	local rc
	TESTLIST="asdf:blah"
	PMLIST_NAME=TESTLIST
	if ! pmlist_is_present asdf ; then
		fail "First element not detected"
	fi
	if ! pmlist_is_present blah ; then
		fail "Last element not detected"
	fi
	if pmlist_is_present foobar ; then
		fail "Random element detected"
	fi
}

test_pmlist_is_present_3()
{
	local rc
	TESTLIST="asdf"
	PMLIST_NAME=TESTLIST
	if ! pmlist_is_present asdf ; then
		fail "Single element not detected"
	fi
	if pmlist_is_present foobar ; then
		fail "Random element detected"
	fi
}

test_pmlist_is_present_4()
{
	local rc
	TESTLIST=
	PMLIST_NAME=TESTLIST
	if ! pmlist_is_present ; then
		fail "Empty element not detected"
	fi
	if pmlist_is_present foobar ; then
		fail "Element detected in empty list"
	fi
}

test_pmlist_is_present_5()
{
	local rc
	TESTLIST=":asdf:"
	PMLIST_NAME=TESTLIST
	if ! pmlist_is_present ; then
		fail "Empty element not detected"
	fi
	if ! pmlist_is_present asdf ; then
		fail "Element not detected between empty elements"
	fi
}

test_pmlist_merge()
{
	local rc
	TESTLIST="asdf:blah:foo"
	PMLIST_NAME=TESTLIST
	pmlist_merge "bar:blah"
	assertEquals "asdf:blah:foo:bar" "$TESTLIST"
}

test_pmlist_merge_2()
{
	local rc
	TESTLIST="asdf"
	PMLIST_NAME=TESTLIST
	pmlist_merge "bar:blah"
	assertEquals "asdf:bar:blah" "$TESTLIST"
}
setUp()
{
	unset PMLIST_NAME
}

# loading shunit2
. ../shunit2/source/2.1/src/shunit2
