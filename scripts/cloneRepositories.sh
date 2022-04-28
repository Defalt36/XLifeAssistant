#!/bin/bash

if [ $# -ne 1 ] ; then
	echo "You must use one argument. Open ${0##*/} in a file editor for more info."
    # First argument: Mode 'shallow' or 'full'
	exit
fi

mode=$1

cd $WORKDIR

rm -rf $GAMEDIR
rm -rf $MINORDIR
rm -rf $DATADIR

if [ $mode == "shallow" ] ; then
	# clones just a branch shallowly for you to just build instead of working on it
	git clone --depth=1 https://github.com/$REMOTEGAME_USER/$REMOTEGAME -b $REMOTEGAME_BRANCH --single-branch $GAMEDIR
	git clone --depth=1 https://github.com/$REMOTEMINOR_USER/$REMOTEMINOR -b $REMOTEMINOR_BRANCH --single-branch $MINORDIR
	git clone --depth=1 https://github.com/$REMOTEDATA_USER/$REMOTEDATA -b $REMOTEDATA_BRANCH --single-branch $DATADIR
elif [ $mode == "full" ] ; then
	#clones all branches deeply
	git clone https://github.com/$REMOTEGAME_USER/$REMOTEGAME $GAMEDIR
	git clone https://github.com/$REMOTEMINOR_USER/$REMOTEMINOR $MINORDIR
	git clone https://github.com/$REMOTEDATA_USER/$REMOTEDATA $DATADIR
fi


