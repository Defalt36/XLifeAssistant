#!/bin/sh

### To avoid installing something you do not want run the commands manually

cd $WORKDIR

sudo apt-get --assume-yes update
sudo apt-get --assume-yes install git g++ imagemagick xclip libsdl1.2-dev libglu1-mesa-dev libgl1-mesa-dev
sudo apt-get --assume-yes install mingw-w64
sudo apt-get --assume-yes install pkg-config
sudo apt-get --assume-yes install build-essential
sudo apt-get --assume-yes install p7zip-full
sudo apt-get --assume-yes install dos2unix

cd $SCRIPTSDIR

./crossInstallLibrary.sh libz libpng libsdl
