#!/bin/bash

##
# Install autoconf, automake and libtool smoothly on Mac OS X.
# Newer versions of these libraries are available and may work better on OS X
#
# This script is originally from http://jsdelfino.blogspot.com.au/2012/08/autoconf-and-automake-on-mac-os-x.html
# This script has been adapted from https://gist.github.com/jellybeansoup/4192307
#

BUILD_DIR=`pwd`
BUILD_PREFIX=/usr/local

AUTOCONF_VERSION=2.69
AUTOMAKE_VERSION=1.15
LIBTOOL_VERSION=2.4.6
LIBEVENT_VERSION=2.0.22-stable
CMAKE_VERSION=3.3.2
TMUX_VERSION=2.1
TMUX_MCL_VERSION=3.2.3
LIBDVDCSS_VERSION=1.4.0

##
# pkg-config
# https://www.freedesktop.org/wiki/Software/pkg-config/

cd $BUILD_DIR
curl -vOL https://pkg-config.freedesktop.org/releases/pkg-config-0.29.1.tar.gz
tar xzf pkg-config-0.29.1.tar.gz
cd pkg-config-0.29.1/
./configure --prefix=${BUILD_PREFIX} --with-internal-glib
make
sudo make install
pkg-config --version

##
# Autoconf
# http://ftpmirror.gnu.org/autoconf

cd $BUILD_DIR
curl -vOL http://ftpmirror.gnu.org/autoconf/autoconf-${AUTOCONF_VERSION}.tar.gz
tar xzf autoconf-${AUTOCONF_VERSION}.tar.gz
cd autoconf-${AUTOCONF_VERSION}
./configure --prefix=${BUILD_PREFIX}
make
sudo make install

##
# Automake
# http://ftpmirror.gnu.org/automake

cd $BUILD_DIR
curl -vOL http://ftpmirror.gnu.org/automake/automake-${AUTOMAKE_VERSION}.tar.gz
tar xzf automake-${AUTOMAKE_VERSION}.tar.gz
cd automake-${AUTOMAKE_VERSION}
./configure --prefix=${BUILD_PREFIX}
make
sudo make install

###
## Libtool
## http://ftpmirror.gnu.org/libtool

cd $BUILD_DIR
curl -vOL http://ftpmirror.gnu.org/libtool/libtool-${LIBTOOL_VERSION}.tar.gz
tar xzf libtool-${LIBTOOL_VERSION}.tar.gz
cd libtool-${LIBTOOL_VERSION}
./configure --prefix=${BUILD_PREFIX}
make
sudo make install
sudo ln -s /usr/local/bin/libtool /usr/local/bin/glibtool # because shit
sudo ln -s /usr/local/bin/libtoolize /usr/local/bin/glibtoolize # ¯\_(ツ)_/¯
libtool --version

###
## Libvent
## http://sourceforge.net/projects/levent/files/libevent/

cd $BUILD_DIR
curl -vOL http://downloads.sourceforge.net/project/levent/libevent/libevent-2.0/libevent-${LIBEVENT_VERSION}.tar.gz
tar xzf libevent-${LIBEVENT_VERSION}.tar.gz
cd libevent-${LIBEVENT_VERSION}
./configure --prefix=${BUILD_PREFIX}
make
sudo make install

###
## CMake
## https://cmake.org/download/

cd ${BUILD_DIR}
curl -vOL https://cmake.org/files/v3.3/cmake-${CMAKE_VERSION}-Darwin-x86_64.tar.gz
tar xzf cmake-${CMAKE_VERSION}-Darwin-x86_64
cd cmake-${CMAKE_VERSION}-Darwin-x86_64/CMake.app/Contents
sudo mv bin/cmake /usr/local/bin/
sudo mv share/cmake-3.3 /usr/local/share/

###
## Tmux
## https://github.com/tmux/tmux

cd $BUILD_DIR
curl -vOL https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz
tar xzf tmux-${TMUX_VERSION}.tar.gz
cd tmux-${TMUX_VERSION}
./configure --prefix=${BUILD_PREFIX}
make
sudo make install

###
## tmux-mem-cpu-load
## https://github.com/thewtex/tmux-mem-cpu-load

cd $BUILD_DIR
curl -vOL https://github.com/thewtex/tmux-mem-cpu-load/archive/v${TMUX_MCL_VERSION}.tar.gz
tar xzf v${TMUX_MCL_VERSION}.tar.gz
cd tmux-mem-cpu-load-${TMUX_MCL_VERSION}
cmake .
make
sudo make install

###
## socat
##

cd ${BUILD_DIR}
curl -vOL "http://www.dest-unreach.org/socat/download/socat-${SOCAT_VERSION}.tar.gz"
tar xzf "socat-.tar.gz"
cd "socat-${SOCAT_VERSION}"
./configure --prefix=${BUILD_PREFIX}
make
sudo make install

###
## libdvdcss
##

#cd ${BUILD_PREFIX}
#curl -vOL "http://download.videolan.org/pub/libdvdcss/${LIBDVDCSS_VERSION}/libdvdcss-${LIBDVDCSS_VERSION}.tar.bz2"
#tar xzf "libdvdcss-${LIBDVDCSS_VERSION}.tar.bz2"
#cd "libdvdcss-${LIBDVDCSS_VERSION}"
#./configure --prefix=${BUILD_PREFIX}
#make
#sudo make install

###
## libffi
## http://linuxfromscratch.org/blfs/view/svn/general/libffi.html

curl -vOL ftp://sourceware.org/pub/libffi/libffi-3.2.1.tar.gz
tar xzf libffi-3.2.1.tar.gz
cd libffi-3.2.1/
./configure --prefix=/usr/local --disable-static
make
sudo make install

###
## gettext
## http://www.gnu.org/software/gettext/gettext.html

curl -vOL http://ftp.gnu.org/pub/gnu/gettext/gettext-0.19.8.1.tar.xz
tar xzf gettext-0.19.8.1.tar.xz
cd gettext-0.19.8.1/
./configure --prefix=/usr/local
make
sudo make install
gettext --version

###
## pcre
## http://pcre.org/

curl -vOL ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.39.tar.gz
cd pcre-8.39/
./configure --prefix=/usr/local --enable-unicode-properties
make
sudo make install
pcre-config --version

###
## glib
## http://ftp.gnome.org/pub/GNOME/sources/glib/

curl -vOL http://ftp.gnome.org/pub/GNOME/sources/glib/2.49/glib-2.49.1.tar.xz
tar xzf glib-2.49.1.tar.xz
cd glib-2.49.1/
./configure --prefix=/usr/local
make
sudo make install

###
## neovim
## https://github.com/neovim/neovim/wiki/Building-Neovim#optimized-builds

curl -vOL https://github.com/neovim/neovim/archive/master.tar.gz
tar xzf master.tar.gz
cd neovim-master
make CMAKE_BUILD_TYPE=Release
sudo make install

echo "Installation complete."

###
## fzf
##

curl -vOL https://github.com/junegunn/fzf/archive/master.tar.gz
tar xzf master.tar.gz
cd fzf-master
./install
