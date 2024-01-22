#!/bin/bash

export ASSISTANTDIR=$SCRIPT_DIR
export WORKDIR=$SCRIPT_DIR/..

export GAMEDIR=$WORKDIR/OneLife
export MINORDIR=$WORKDIR/minorGems 
export DATADIR=$WORKDIR/OneLifeData7


export TIMESTAMP=$(date '+(%F,%H%M)')
export RELEASENAME=OneLife
export TARGETSYSTEM=linux

export REMOTEGAME=OneLife
export REMOTEGAME_USER=twohoursonelife
export REMOTEGAME_BRANCH=master

export REMOTEMINOR=minorGems
export REMOTEMINOR_USER=twohoursonelife
export REMOTEMINOR_BRANCH=master

export REMOTEDATA=OneLifeData7
export REMOTEDATA_USER=twohoursonelife
export REMOTEDATA_BRANCH=master

export TESTBUILDFOLDER=$ASSISTANTDIR
export TESTBUILDNAME=XLife_test

export BUILDSDIR=$WORKDIR/builds
export LIBRARYDIR=$WORKDIR/libraries

if [ -z $BUILDSDIR ] ; then
    mkdir $BUILDSDIR
fi

if [ -z $LIBRARYDIR ] ; then
    mkdir $LIBRARYDIR
fi


