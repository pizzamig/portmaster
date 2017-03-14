#!/bin/sh

for t in pm_*.sh ; do
	if ! ./$t ; then
		exit $?
	fi
done
