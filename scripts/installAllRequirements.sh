#!/bin/sh

### To avoid installing something you will not run the commands manually

cd $WORKDIR

sudo apt-get --assume-yes update
sudo apt-get --assume-yes install git g++ imagemagick xclip libsdl1.2-dev libglu1-mesa-dev libgl1-mesa-dev
sudo apt-get --assume-yes install mingw-w64
sudo apt-get --assume-yes install build-essential
sudo apt-get --assume-yes install p7zip-full

./crossInstallLibraries.sh libz
./crossInstallLibraries.sh libpng
./crossInstallLibraries.sh libsdl
./crossInstallLibraries.sh libfreetype