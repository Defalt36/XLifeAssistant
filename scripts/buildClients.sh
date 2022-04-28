#!/bin/bash

pushd

### CLEANING
./cleanBuilds.sh

### LINUX
RELEASEDIR = $BUILDSDIR/$RELEASENAME_$TIMESTAMP_linux

cd $GAMEDIR

chmod u+x configure
./configure 1 || exit 1

cd gameSource
make || exit 1

popd

./gatherData.sh all $RELEASEDIR copy
./gatherBuildFiles.sh game $RELEASEDIR
./gatherBinaries.sh linux game $RELEASEDIR

ln -sf $RELEASEDIR $RELEASENAME

7z a $RELEASEDIR.zip $RELEASENAME

### CLEANING
./cleanBuilds.sh

### WINDOWS
RELEASEDIR = $BUILDSDIR/$RELEASENAME_$TIMESTAMP_windows

cd $GAMEDIR

chmod u+x configure
./configure 5 || exit 1

cd gameSource
make || exit 1

popd

./gatherData.sh all $RELEASEDIR copy
./gatherBuildFiles.sh game $RELEASEDIR
./gatherBinaries.sh windows game $RELEASEDIR

ln -sf $RELEASEDIR $RELEASENAME

7z a $RELEASEDIR.zip $RELEASENAME

### CLEANING
./cleanBuilds.sh


