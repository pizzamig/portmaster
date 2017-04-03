#!/bin/sh
. ../portmaster.subr

# test cases
test_pmlist_is_present()
{
	TESTLIST="asdf:blah:foo"
	if ! pmlist_is_present asdf $TESTLIST ; then
		fail "First element not detected"
	fi
	if ! pmlist_is_present blah $TESTLIST ; then
		fail "Middle element not detected"
	fi
	if ! pmlist_is_present foo $TESTLIST ; then
		fail "Last element not detected"
	fi
	if pmlist_is_present foobar $TESTLIST ; then
		fail "Random element detected"
	fi
}

test_pmlist_is_present_2()
{
	TESTLIST="asdf:blah"
	if ! pmlist_is_present asdf $TESTLIST ; then
		fail "First element not detected"
	fi
	if ! pmlist_is_present blah $TESTLIST ; then
		fail "Last element not detected"
	fi
	if pmlist_is_present foobar $TESTLIST ; then
		fail "Random element detected"
	fi
}

test_pmlist_is_present_3()
{
	TESTLIST="asdf"
	if ! pmlist_is_present asdf $TESTLIST ; then
		fail "Single element not detected"
	fi
	if pmlist_is_present foobar $TESTLIST ; then
		fail "Random element detected"
	fi
}

test_pmlist_is_present_4()
{
	TESTLIST=
	if ! pmlist_is_present $TESTLIST ; then
		fail "Empty element not detected"
	fi
	if pmlist_is_present foobar $TESTLIST ; then
		fail "Element detected in empty list"
	fi
}

test_pmlist_is_present_5()
{
	TESTLIST=":asdf:"
	if ! pmlist_is_present "" $TESTLIST ; then
		fail "Empty element not detected"
	fi
	if ! pmlist_is_present asdf $TESTLIST ; then
		fail "Element not detected between empty elements"
	fi
}

test_pmlist_merge()
{
	TESTLIST="asdf:blah:foo"
	TESTLIST="$(pmlist_merge "$TESTLIST" "bar:blah")"
	assertEquals "asdf:blah:foo:bar" "$TESTLIST"
}

test_pmlist_merge_2()
{
	TESTLIST="asdf"
	TESTLIST="$( pmlist_merge "$TESTLIST" "bar:blah" )"
	assertEquals "asdf:bar:blah" "$TESTLIST"
}

test_pmlist_pop()
{
	local rv
	TESTLIST="asdf:blah:foo"
	rv=$(pmlist_pop $TESTLIST)
	TESTLIST=$(pmlist_pop_list $rv $TESTLIST)
	assertEquals "asdf" "$rv"
	assertEquals "blah:foo" "$TESTLIST"
	rv=$(pmlist_pop $TESTLIST)
	TESTLIST=$(pmlist_pop_list $rv $TESTLIST)
	assertEquals "blah" "$rv"
	assertEquals "foo" "$TESTLIST"
	rv=$(pmlist_pop $TESTLIST)
	TESTLIST=$(pmlist_pop_list $rv $TESTLIST)
	assertEquals "foo" "$rv"
	assertEquals "" "$TESTLIST"
	rv=$(pmlist_pop $TESTLIST)
	assertEquals "" "$rv"
}

test_pmlist_pop_2()
{
	local rv
	TESTLIST=":asdf:blah:foo:"
	rv=$(pmlist_pop $TESTLIST)
	TESTLIST=$(pmlist_pop_list $rv $TESTLIST)
	assertEquals "asdf" "$rv"
	assertEquals "blah:foo:" "$TESTLIST"
	rv=$(pmlist_pop $TESTLIST)
	TESTLIST=$(pmlist_pop_list $rv $TESTLIST)
	assertEquals "blah" "$rv"
	assertEquals "foo:" "$TESTLIST"
	rv=$(pmlist_pop $TESTLIST)
	TESTLIST=$(pmlist_pop_list $rv $TESTLIST)
	assertEquals "foo" "$rv"
	assertEquals "" "$TESTLIST"
	rv=$(pmlist_pop $TESTLIST)
	assertEquals "" "$rv"
}

test_pmlist_pop_3()
{
	local rv
	TESTLIST=":"
	rv=$(pmlist_pop $TESTLIST)
	TESTLIST=$(pmlist_pop_list "$rv" $TESTLIST)
	assertEquals "" "$rv"
	assertEquals ":" "$TESTLIST"
}

# loading shunit2
. ../shunit2/source/2.1/src/shunit2
