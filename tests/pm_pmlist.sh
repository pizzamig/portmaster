#!/bin/sh
. ../portmaster.subr

# test cases
test_pmlist_is_present()
{
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
	TESTLIST="asdf:blah:foo"
	PMLIST_NAME=TESTLIST
	pmlist_merge "bar:blah"
	assertEquals "asdf:blah:foo:bar" "$TESTLIST"
}

test_pmlist_merge_2()
{
	TESTLIST="asdf"
	PMLIST_NAME=TESTLIST
	pmlist_merge "bar:blah"
	assertEquals "asdf:bar:blah" "$TESTLIST"
}

test_pmlist_pop()
{
	local rv
	TESTLIST="asdf:blah:foo"
	PMLIST_NAME=TESTLIST
	rv=$(pmlist_pop)
	TESTLIST=$(pmlist_pop_list $rv)
	assertEquals "asdf" "$rv"
	assertEquals "blah:foo" "$TESTLIST"
	rv=$(pmlist_pop)
	TESTLIST=$(pmlist_pop_list $rv)
	assertEquals "blah" "$rv"
	assertEquals "foo" "$TESTLIST"
	rv=$(pmlist_pop)
	TESTLIST=$(pmlist_pop_list $rv)
	assertEquals "foo" "$rv"
	assertEquals "" "$TESTLIST"
	rv=$(pmlist_pop)
	assertEquals "" "$rv"
}

test_pmlist_pop_2()
{
	local rv
	TESTLIST=":asdf:blah:foo:"
	PMLIST_NAME=TESTLIST
	rv=$(pmlist_pop)
	TESTLIST=$(pmlist_pop_list $rv)
	assertEquals "asdf" "$rv"
	assertEquals "blah:foo:" "$TESTLIST"
	rv=$(pmlist_pop)
	TESTLIST=$(pmlist_pop_list $rv)
	assertEquals "blah" "$rv"
	assertEquals "foo:" "$TESTLIST"
	rv=$(pmlist_pop)
	TESTLIST=$(pmlist_pop_list $rv)
	assertEquals "foo" "$rv"
	assertEquals "" "$TESTLIST"
	rv=$(pmlist_pop)
	assertEquals "" "$rv"
}

test_pmlist_pop_3()
{
	local rv
	TESTLIST=":"
	PMLIST_NAME=TESTLIST
	rv=$(pmlist_pop)
	TESTLIST=$(pmlist_pop_list $rv)
	assertEquals "" "$rv"
	assertEquals ":" "$TESTLIST"
}

setUp()
{
	unset PMLIST_NAME
}

# loading shunit2
. ../shunit2/source/2.1/src/shunit2
