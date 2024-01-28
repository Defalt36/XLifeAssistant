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
	
	if [ ! -d zlib-1.3.1 ] ; then
		wget https://zlib.net/zlib-1.3.1.tar.gz -O- | tar xfz -
		# if wget fails try alternative mirror
		if [ $? -ne 0 ]; then
			wget https://github.com/madler/zlib/releases/download/v1.3.1/zlib-1.3.1.tar.gz -O- | tar xfz -
		fi
	fi
	
	cd zlib-1.3.1
	sudo make -f win32/Makefile.gcc \
		BINARY_PATH=$prefixdir/bin \
		INCLUDE_PATH=$prefixdir/include \
		LIBRARY_PATH=$prefixdir/lib \
		SHARED_MODE=1 \
		PREFIX=$host- \
		install
	cd ..
	rm -rf zlib-1.3.1-source
	mv zlib-1.3.1 zlib-1.3.1-source
fi


if [ $library = "libpng" ] ; then
	#LibPng won't install propely if Zlib isn't installed fist
	echo
	echo "Preparing LibPNG..."
	
	if [ ! -d libpng-1.6.40	] ; then
		wget https://downloads.sourceforge.net/project/libpng/libpng16/1.6.40/libpng-1.6.40.tar.gz -O- | tar xfz -
		# if wget fails try alternative mirror
		if [ $? -ne 0 ]; then
			wget https://github.com/pnggroup/libpng/archive/refs/tags/v1.6.40.tar.gz -O- | tar xfz -
		fi
	fi
	
	cd libpng-1.6.40
	./configure \
		--host=$host \
		--prefix=$prefixdir \
		CPPFLAGS="-I${prefixdir}/include" \
		LDFLAGS="-L${prefixdir}/lib"
	make
	sudo make install
	cd ..
	rm -rf libpng-1.6.40-source
	mv libpng-1.6.40 libpng-1.6.40-source
fi

if [ $library = "libsdl" ] ; then
	echo
	echo "Preparing LibSDL..."
	
	if [ ! -d SDL-1.2.15 ] ; then
		wget https://www.libsdl.org/release/SDL-1.2.15.tar.gz -O- | tar xfz -
		# if wget fails try alternative mirror
		if [ $? -ne 0 ]; then
			wget https://github.com/libsdl-org/SDL-1.2/archive/refs/tags/release-1.2.15.tar.gz -O- | tar xfz -
		fi
	fi
	
	cd SDL-1.2.15
	./configure \
		--bindir=$prefixdir/bin \
		--libdir=$prefixdir/lib \
		--includedir=$prefixdir/include \
		--host=$host \
		--prefix=$prefixdir \
		CPPFLAGS="-I${prefixdir}/include" \
		LDFLAGS="-L${prefixdir}/lib"
	make
	sudo make install
	cd ..
	rm -rf SDL-1.2.15-source
	mv SDL-1.2.15 SDL-1.2.15-source
fi

if [ $library = "libfreetype" ] ; then
	echo
	echo "Preparing FreeType2..."
	
	if [ ! -d $LIBRARYDIR/freetype-2.13.2 ] ; then
		wget https://downloads.sourceforge.net/project/freetype/freetype2/2.13.2/freetype-2.13.2.tar.gz -O- | tar xfz -
		# if wget fails try alternative mirror
		if [ $? -ne 0 ]; then
			wget https://download.savannah.gnu.org/releases/freetype/freetype-2.13.2.tar.gz -O- | tar xfz -
		fi
	fi
	
	cd freetype-2.13.2
	./configure \
		--prefix=$prefixdir \
		--build=$build \
		--host=$host \
		--enable-static \
		CPPFLAGS="-I${prefixdir}/include" \
		LDFLAGS="-L${prefixdir}/lib" \
		PKG_CONFIG_LIBDIR=$prefixdir/lib/pkgconfig
	make
	sudo make install
	cd ..
	rm -rf freetype-2.13.2-source
	mv freetype-2.13.2 freetype-2.13.2-source
fi


