#!/bin/sh

### To avoid installing something you do not want run the commands manually

cd $WORKDIR


sudo apt-get --assume-yes update
sudo apt-get --assume-yes install rsync wget unzip git p7zip-full dos2unix net-tools
sudo apt-get --assume-yes install imagemagick xclip libglu1-mesa-dev libgl1-mesa-dev libsdl1.2-dev
sudo apt-get --assume-yes install mingw-w64 build-essential

mkdir -p dependencies
cd dependencies
if [ ! -d discord_game_sdk ]; then
	wget https://dl-game-sdk.discordapp.net/3.2.1/discord_game_sdk.zip
	unzip -d discord_game_sdk discord_game_sdk.zip
	rm discord_game_sdk.zip
fi

cd $SCRIPTSDIR

./crossInstallLibrary.sh libz libpng libsdl
