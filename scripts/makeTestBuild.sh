#!/bin/bash

if [ $# -ne 1 ] ; then
	echo "You must use one argument. Open ${0##*/} in a file editor for more info."
    # First argument: Target 'linux' or 'windows'
	exit
fi

target=$1

TESTDIR=$TESTBUILDFOLDER/$TESTBUILDNAME-$target
mkdir $TESTDIR

cd $GAMEDIR

chmod u+x configure ./server/configure

if [ $target == "linux" ] ; then
	./configure 1 || exit 1
	cd server
	./configure 1 || exit 1
	cd ..
elif [ $target == "windows" ] ; then
	./configure 5 || exit 1
	cd server
	./configure 5 || exit 1
	cd ..
fi

cd gameSource

make

./makeEditor.sh

cd ../server
make

cd $SCRIPTSDIR

./gatherData.sh all $TESTDIR rsync
./gatherBuildFiles.sh game $TESTDIR
./gatherBuildFiles.sh server $TESTDIR
./gatherBinaries.sh $target all $TESTDIR

echo 0 > $TESTDIR/settings/fullscreen.ini
echo 1 > $TESTDIR/settings/useCustomServer.ini
echo localhost > $TESTDIR/settings/CustomServerAddress.ini
echo 8005 > $TESTDIR/settings/customServerPort.ini
echo 1 > $TESTDIR/settings/vogModeOn.ini
echo 1 > $TESTDIR/settings/tutorialDone.ini
echo "ELITE" > $TESTDIR/settings/email.ini
echo "31337" > $TESTDIR/settings/password.ini

echo 0 > $TESTDIR/settings/requireTicketServerCheck.ini
echo 1 > $TESTDIR/settings/useTestMap.ini
echo 1 > $TESTDIR/settings/allowVOGMode.ini
echo 1 > $TESTDIR/settings/allowMapRequests.ini
echo "ELITE" > $TESTDIR/settings/vogAllowAccounts.ini


