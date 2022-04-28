#!/bin/bash

if [ $# -ne 1 ] ; then
	echo "You must use one argument. Open ${0##*/} in a file editor for more info."
    # First argument: Target 'linux' or 'windows'
	exit
fi

target = $1

pushd

RELEASEDIR = $BUILDSDIR/$RELEASENAME_$TIMESTAMP

cd $GAMEDIR

chmod u+x configure /server/configure

if [ $target == "linux" ] ; then
	./configure 1 || exit 1
	./server/configure 1 || exit 1
elif [ $target == "windows" ] ; then
	./configure 5 || exit 1
	./server/configure 5 || exit 1
fi

cd gameSource

make || exit 1

./makeEditor.sh

cd ../server
make || exit 1

popd

./gatherData.sh all $RELEASEDIR copy
./gatherBuildFiles.sh game $RELEASEDIR
./gatherBuildFiles.sh server $RELEASEDIR
./gatherBinaries.sh $target all $RELEASEDIR

ln -sf $RELEASEDIR $RELEASENAME

7z a $RELEASEDIR.zip $RELEASENAME


