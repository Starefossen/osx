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
TMUX_MCL_VERSION=3.2.2

##
# Autoconf
# http://ftpmirror.gnu.org/autoconf

cd $BUILD_DIR
curl -OL http://ftpmirror.gnu.org/autoconf/autoconf-${AUTOCONF_VERSION}.tar.gz
tar xzf autoconf-${AUTOCONF_VERSION}.tar.gz
cd autoconf-${AUTOCONF_VERSION}
./configure --prefix=${BUILD_PREFIX}
make
sudo make install

##
# Automake
# http://ftpmirror.gnu.org/automake

cd $BUILD_DIR
curl -OL http://ftpmirror.gnu.org/automake/automake-${AUTOMAKE_VERSION}.tar.gz
tar xzf automake-${AUTOMAKE_VERSION}.tar.gz
cd automake-${AUTOMAKE_VERSION}
./configure --prefix=${BUILD_PREFIX}
make
sudo make install

###
## Libtool
## http://ftpmirror.gnu.org/libtool

cd $BUILD_DIR
curl -OL http://ftpmirror.gnu.org/libtool/libtool-${LIBTOOL_VERSION}.tar.gz
tar xzf libtool-${LIBTOOL_VERSION}.tar.gz
cd libtool-${LIBTOOL_VERSION}
./configure --prefix=${BUILD_PREFIX}
make
sudo make install

###
## Libvent
## http://sourceforge.net/projects/levent/files/libevent/

cd $BUILD_DIR
curl -OL http://downloads.sourceforge.net/project/levent/libevent/libevent-2.0/libevent-${LIBEVENT_VERSION}.tar.gz
tar xzf libevent-${LIBEVENT_VERSION}.tar.gz
cd libevent-${LIBEVENT_VERSION}
./configure --prefix=${BUILD_PREFIX}
make
sudo make install

###
## CMake
## https://cmake.org/download/

cd ${BUILD_DIR}
curl -OL https://cmake.org/files/v3.3/cmake-${CMAKE_VERSION}-Darwin-x86_64.tar.gz
tar xzf cmake-${CMAKE_VERSION}-Darwin-x86_64
sudo mv cmake-${CMAKE_VERSION}-Darwin-x86_64/CMake.app/Contents/bin/cmake /usr/local/bin/cmake

###
## Tmux
## https://github.com/tmux/tmux

cd $BUILD_DIR
curl -OL https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz
tar xzf tmux-${TMUX_VERSION}.tar.gz
cd tmux-${TMUX_VERSION}
./configure --prefix=${BUILD_PREFIX}
make
sudo make install

###
## tmux-mem-cpu-load
## https://github.com/thewtex/tmux-mem-cpu-load

cd $BUILD_DIR
curl -OL https://github.com/thewtex/tmux-mem-cpu-load/archive/v${TMUX_MCL_VERSION}.tar.gz
tar xzf v${TMUX_MCL_VERSION}.tar.gz
cd tmux-mem-cpu-load-${TMUX_MCL_VERSION}
cmake .
make
sudo make install

echo "Installation complete."
