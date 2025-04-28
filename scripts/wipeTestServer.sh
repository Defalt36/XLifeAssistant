#!/bin/bash

TESTDIR=$TESTBUILDPATH

( cd $TESTDIR ; rm -v map.db.trunc \
biomeRandSeed.txt curseSave.txt kissTest.txt familyDataLog.txt log.txt recentPlacements.txt testMapStale.txt \
mapDummyRecall.txt shutdownLongLineagePos.txt lastEveLocation.txt )

cd $TESTDIR

find . -type f -name '*.db' -exec rm -v {} +

for directory in 'curseLog' 'failureLog' 'foodLog' 'lifelog' 'mapChangeLogs' ; do
    find $directory -maxdepth 1 -type f -name '*.txt' -exec rm -v {} +
done
