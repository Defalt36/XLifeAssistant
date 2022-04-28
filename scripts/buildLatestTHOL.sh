#!/bin/bash

if [ $# -ne 1 ] ; then
	echo "You must use one argument. Open ${0##*/} in a file editor for more info."
    # First argument: Target 'linux' or 'windows'
	exit
fi

target=$1

RELEASEDIR=$BUILDSDIR/$RELEASENAME-$TIMESTAMP-$target

pushd .

cd $WORKDIR

if [ ! -e minorGems ]
then
	git clone https://github.com/twohoursonelife/minorGems.git	
fi

if [ ! -e OneLife ]
then
	git clone https://github.com/twohoursonelife/OneLife.git
fi

if [ ! -e OneLifeData7 ]
then
	git clone https://github.com/twohoursonelife/OneLifeData7.git	
fi


cd minorGems
git fetch --tags
latestTaggedVersion=`git for-each-ref --sort=-creatordate --format '%(refname:short)' --count=1 refs/tags/OneLife_v* | sed -e 's/OneLife_v//'`
git checkout -q 2HOL_v$latestTaggedVersion


cd ../OneLife
git fetch --tags
latestTaggedVersionA=`git for-each-ref --sort=-creatordate --format '%(refname:short)' --count=1 refs/tags/OneLife_v* | sed -e 's/OneLife_v//'`
git checkout -q 2HOL_v$latestTaggedVersionA


cd ../OneLifeData7
git fetch --tags
latestTaggedVersionB=`git for-each-ref --sort=-creatordate --format '%(refname:short)' --count=1 refs/tags/OneLife_v* | sed -e 's/OneLife_v//'`
git checkout -q 2HOL_v$latestTaggedVersionB

rm */cache.fcz

cd ..

latestVersion=$latestTaggedVersionB


if [ $latestTaggedVersionA -gt $latestTaggedVersionB ]
then
	latestVersion=$latestTaggedVersionA
fi

echo
echo "Building v$latestVersion..."

cd OneLife

chmod u+x ./configure

if [ $target == "linux" ] ; then
	./configure 1 || exit 1
elif [ $target == "windows" ] ; then
	./configure 5 || exit 1
fi

cd gameSource

make || exit 1

popd

mkdir $RELEASEDIR

$ASSISTANTDIR/scripts/gatherData.sh game $RELEASEDIR copy
$ASSISTANTDIR/scripts/gatherBuildFiles.sh game $RELEASEDIR
$ASSISTANTDIR/scripts/gatherBinaries.sh $target game $RELEASEDIR

ln -vsf $RELEASEDIR $BUILDSDIR/$RELEASENAME

7z a $BUILDSDIR/$(basename $RELEASEDIR).zip $BUILDSDIR/$RELEASENAME

echo
echo "Done building v$latestVersion."


