#!/bin/bash

TESTDIR=$TESTBUILDPATH

( cd $TESTDIR ; rm -v biome.db eve.db floor.db floorTime.db grave.db lookTime.db map.db mapTime.db meta.db playerStats.db \
map.db.trunc \
biomeRandSeed.txt familyDataLog.txt log.txt recentPlacements.txt testMapStale.txt \
mapDummyRecall.txt shutdownLongLineagePos.txt lastEveLocation.txt )

find $TESTDIR/curseLog -type f -name '*.txt' -exec rm -v {} +
find $TESTDIR/failureLog -type f -name '*.txt' -exec rm -v {} +
find $TESTDIR/foodLog -type f -name '*.txt' -exec rm -v {} +
find $TESTDIR/lifelog -type f -name '*.txt' -exec rm -v {} +
find $TESTDIR/mapChangeLogs -type f -name '*.txt' -exec rm -v {} +
