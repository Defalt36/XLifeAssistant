#!/bin/bash

if [ $# -ne 1 ] ; then
	echo "You must use one argument. Open ${0##*/} in a file editor for more info."
    # First argument: Library 'libpng', 'libz', 'libsdl' or 'libfreetype'
	exit
fi

library=$1

build="x86_64-linux-gnu"
host="i686-w64-mingw32"
prefixdir="/usr/i686-w64-mingw32"

# keep the libraries in case you want to uninstall them later
if [ ! -e $LIBRARYDIR ]
then
	mkdir -v $LIBRARYDIR
fi

cd $LIBRARYDIR

if [ $library = "libz" ] ; then
	echo
	echo "Preparing LibZ..."
	rm -rf zlib-1.3.1
	#wget https://github.com/madler/zlib/releases/download/v1.3.1/zlib-1.3.1.tar.gz -O- | tar xfz -
	wget https://zlib.net/zlib-1.3.1.tar.gz -O- | tar xfz -
	cd zlib-1.3.1
	sudo make -f win32/Makefile.gcc BINARY_PATH=$prefixdir/bin INCLUDE_PATH=$prefixdir/include LIBRARY_PATH=$prefixdir/lib SHARED_MODE=1 PREFIX=$host- install
	cd ..
	mv zlib-1.3.1 zlib-1.3.1_source
fi


if [ $library = "libpng" ] ; then
	#LibPng won't install propely if Zlib isn't installed fist
	echo
	echo "Preparing LibPNG..."
	rm -rf libpng-1.6.40
	#wget https://github.com/pnggroup/libpng/archive/refs/tags/v1.6.40.tar.gz -O- | tar xfz -
	wget https://downloads.sourceforge.net/project/libpng/libpng16/1.6.40/libpng-1.6.40.tar.gz -O- | tar xfz -
	cd libpng-1.6.40
	./configure \
		--host=$host \
		--prefix=$prefixdir \
		CPPFLAGS="-I${prefixdir}/include" \
		LDFLAGS="-L${prefixdir}/lib"
	make
	sudo make install
	cd ..
	mv libpng-1.6.40 libpng-1.6.40_source
fi

if [ $library = "libsdl" ] ; then
	echo
	echo "Preparing LibSDL..."
	rm -rf SDL-1.2.15
	wget https://www.libsdl.org/release/SDL-1.2.15.tar.gz -O- | tar xfz -
	cd SDL-1.2.15
	./configure \
		--bindir=$prefixdir/bin \
		--libdir=$prefixdir/lib \
		--includedir=$prefixdir/include \
		--host=i686-w64-mingw32 \
		--prefix=$prefixdir \
		CPPFLAGS="-I${prefixdir}/include" \
		LDFLAGS="-L${prefixdir}/lib"
	make
	sudo make install
	cd ..
	mv SDL-1.2.15 SDL-1.2.15_source
fi

if [ $library = "libfreetype" ] ; then
	echo
	echo "Preparing FreeType2..."
	rm -rf freetype-2.13.2
	#wget https://download.savannah.gnu.org/releases/freetype/freetype-2.13.2.tar.gz -O- | tar xfz -
	wget https://downloads.sourceforge.net/project/freetype/freetype2/2.13.2/freetype-2.13.2.tar.gz -O- | tar xfz -
	cd freetype-2.13.2
	./configure \
		--prefix=$prefixdir \
		--build=$build \
		--host=$host \
		CPPFLAGS="-I${prefixdir}/include" \
		LDFLAGS="-L${prefixdir}/lib" \
		PKG_CONFIG_LIBDIR=$prefixdir/lib/pkgconfig
	make
	sudo make install
	cd ..
	mv freetype-2.13.2 freetype-2.13.2_source
fi


