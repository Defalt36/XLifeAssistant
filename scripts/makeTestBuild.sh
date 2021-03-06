#!/bin/bash

if [ $# -ne 1 ] ; then
	echo "You must use one argument. Open ${0##*/} in a file editor for more info."
    # First argument: Target 'linux' or 'windows'
	exit
fi

pushd .

target=$1

TESTDIR=$TESTBUILDFOLDER/$TESTBUILDNAME-$target

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

popd

mkdir $TESTDIR

$ASSISTANTDIR/scripts/gatherData.sh all $TESTDIR rsync
$ASSISTANTDIR/scripts/gatherBuildFiles.sh game $TESTDIR
$ASSISTANTDIR/scripts/gatherBuildFiles.sh server $TESTDIR
$ASSISTANTDIR/scripts/gatherBinaries.sh $target all $TESTDIR

echo 0 > $TESTDIR/settings/fullscreen.ini
echo 1 > $TESTDIR/settings/userCustomServer.ini
echo localhost > $TESTDIR/settings/CustomServerAddress.ini
echo 8005 > $TESTDIR/settings/customServerPort.ini
echo 1 > $TESTDIR/settings/vogModeOn.ini
echo 1 > $TESTDIR/settings/tutorialDone.ini
echo SOMEONE > $TESTDIR/settings/email.ini
echo SOMETHING > $TESTDIR/settings/password.ini

echo 0 > $TESTDIR/settings/requireTicketServerCheck.ini
echo 1 > $TESTDIR/settings/useTestMap.ini
echo 1 > $TESTDIR/settings/allowVOGMode.ini
echo 1 > $TESTDIR/settings/allowMapRequests.ini
echo SOMEONE > $TESTDIR/settings/vogAllowAccounts.ini


