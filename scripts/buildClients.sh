#!/bin/bash

cd $SCRIPTSDIR

### CLEANING
./cleanBuilds.sh

### LINUX
RELEASEDIR=$BUILDSDIR/$RELEASENAME-$TIMESTAMP-linux
mkdir $RELEASEDIR

cd $GAMEDIR

chmod u+x configure
./configure 1 || exit 1

cd gameSource
make || exit 1

cd $SCRIPTSDIR

./gatherData.sh all $RELEASEDIR copy
./gatherBuildFiles.sh game $RELEASEDIR
./gatherBinaries.sh linux game $RELEASEDIR

#ln -sf $RELEASEDIR $RELEASENAME

7z a $RELEASEDIR.zip $RELEASENAME

### CLEANING
./cleanBuilds.sh

### WINDOWS
RELEASEDIR=$BUILDSDIR/$RELEASENAME-$TIMESTAMP-windows

cd $GAMEDIR

chmod u+x configure
./configure 5 || exit 1

cd gameSource
make || exit 1

cd $SCRIPTSDIR

./gatherData.sh all $RELEASEDIR copy
./gatherBuildFiles.sh game $RELEASEDIR
./gatherBinaries.sh windows game $RELEASEDIR

#ln -sf $RELEASEDIR $RELEASENAME

7z a $RELEASEDIR.zip $RELEASENAME

### CLEANING
./cleanBuilds.sh


