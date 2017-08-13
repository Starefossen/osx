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
CMAKE_VERSION=3.6.1
CMAKE_VERSION_MAJOR=3.6
FZF_VERSION=0.16.8
GETTEXT_VERSION=0.19.8.1
GLIB_VERSION=2.49.1
GLIB_VERSION_MAJOR=2.49
LIBEVENT_VERSION=2.0.22-stable
LIBFFI_VERSION=3.2.1
LIBTOOL_VERSION=2.4.6
NEOVIM_VERSION=0.2.0
OPENSSL_VERSION=1.0.2l
PASTEBOARD_VERSION=2.5
PCRE_VERSION=8.39
PKG_CONFIG_VERSION=0.29.1
TMUX_MCL_VERSION=3.4.0
TMUX_VERSION=2.5

##
# pkg-config
# https://www.freedesktop.org/wiki/Software/pkg-config/

PKG_CONFIG_INSTALLED=$(pkg-config --version)
if [ "${PKG_CONFIG_INSTALLED}" != "${PKG_CONFIG_VERSION}" ]
then
  cd $BUILD_DIR
  curl -vOL https://pkg-config.freedesktop.org/releases/pkg-config-${PKG_CONFIG_VERSION}.tar.gz
  tar xzf pkg-config-${PKG_CONFIG_VERSION}.tar.gz
  cd pkg-config-${PKG_CONFIG_VERSION}

  ./configure --prefix=${BUILD_PREFIX} --with-internal-glib \
    && make \
    && sudo make install \
    || exit 1

  pkg-config --version
else
  echo "pkg-config@${PKG_CONFIG_VERSION} is already installed!"
fi

##
# Autoconf
# http://ftpmirror.gnu.org/autoconf

AUTOCONF_VERSION_INSTALLED=$(autoconf --version | head -n 1 | awk '{ print $NF }')
if [ "${AUTOCONF_VERSION_INSTALLED}" != "${AUTOCONF_VERSION}" ]
then
  cd $BUILD_DIR
  curl -vOL http://ftpmirror.gnu.org/autoconf/autoconf-${AUTOCONF_VERSION}.tar.gz
  tar xzf autoconf-${AUTOCONF_VERSION}.tar.gz
  cd autoconf-${AUTOCONF_VERSION}

  ./configure --prefix=${BUILD_PREFIX} \
    && make \
    && sudo make install \
    || exit 1

  autoconf --version
else
  echo "autoconf@${AUTOCONF_VERSION} is already installed!"
fi

##
# Automake
# http://ftpmirror.gnu.org/automake

AUTOMAKE_VERSION_INSTALLED=$(automake --version | head -n 1 | awk '{ print $NF }')
if [ "${AUTOMAKE_VERSION_INSTALLED}" != "${AUTOMAKE_VERSION}" ]
then
  cd $BUILD_DIR
  curl -vOL http://ftpmirror.gnu.org/automake/automake-${AUTOMAKE_VERSION}.tar.gz
  tar xzf automake-${AUTOMAKE_VERSION}.tar.gz
  cd automake-${AUTOMAKE_VERSION}

  ./configure --prefix=${BUILD_PREFIX} \
    && make \
    && sudo make install \
    || exit 1

  automake --version
else
  echo "automake@${AUTOMAKE_VERSION} is already installed!"
fi

###
## Libtool
## http://ftpmirror.gnu.org/libtool

LIBTOOL_VERSION_INSTALLED=$(libtool --version | head -n 1 | awk '{ print $NF }')
if [ "${LIBTOOL_VERSION_INSTALLED}" != "${LIBTOOL_VERSION}" ]
then
  cd $BUILD_DIR
  curl -vOL http://ftpmirror.gnu.org/libtool/libtool-${LIBTOOL_VERSION}.tar.gz
  tar xzf libtool-${LIBTOOL_VERSION}.tar.gz
  cd libtool-${LIBTOOL_VERSION}

  ./configure --prefix=${BUILD_PREFIX} \
    && make \
    && sudo make install \
    || exit 1

  sudo ln -s /usr/local/bin/libtool /usr/local/bin/glibtool # because shit
  sudo ln -s /usr/local/bin/libtoolize /usr/local/bin/glibtoolize # ¯\_(ツ)_/¯

  libtool --version
else
  echo "libtool@${LIBTOOL_VERSION} is already installed!"
fi

###
## OpenSSL
## https://wiki.openssl.org/index.php/Compilation_and_Installation#Mac

OPENSSL_VERSION_INSTALLED=$(openssl version | head -n 1 | awk '{ print $2 }')
if [ "${OPENSSL_VERSION_INSTALLED}" != "${OPENSSL_VERSION}" ]
then
  cd $BUILD_DIR
  curl -vOL https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz
  tar xzf openssl-${OPENSSL_VERSION}.tar.gz
  cb openssl-${OPENSSL_VERSION}

  ./Configure \
    darwin64-x86_64-cc \
    shared \
    enable-ec_nistp_64_gcc_128 \
    no-ssl2 \
    no-ssl3 \
    no-comp \
    --openssldir=/usr/local/ssl/macos-x86_64 \
    --prefix=${BUILD_PREFIX} \
  && make depend \
  && sudo make install \
  || exit 1

  openssl version
else
  echo "openssl@${OPENSSL_VERSION} is already installed!"
fi

###
## Libvent
## https://github.com/libevent/libevent/releases

LIBEVENT_VERSION_INSTALLED=${LIBEVENT_VERSION} # @TODO FIX ME
if [ "${LIBEVENT_VERSION}" != "${LIBEVENT_VERSION}" ]
then
  cd $BUILD_DIR
  curl -vOL https://github.com/libevent/libevent/archive/release-${LIBEVENT_VERSION}.tar.gz
  tar xzf release-${LIBEVENT_VERSION}.tar.gz
  cd libevent-release-${LIBEVENT_VERSION}

  ./autogen.sh && \
  ./configure --prefix=${BUILD_PREFIX} \
    && make \
    && sudo make install \
    || exit 1
else
  echo "libevent@${LIBEVENT_VERSION} is already installed!"
fi

###
## CMake
## https://cmake.org/download

CMAKE_VERSION_INSTALLED=$(cmake --version | head -n 1 | awk '{ print $3 }')
if [ "${CMAKE_VERSION_INSTALLED}" != "${CMAKE_VERSION}" ]
then
  cd ${BUILD_DIR}
  curl -vOL https://cmake.org/files/v${CMAKE_VERSION_MAJOR}/cmake-${CMAKE_VERSION}-Darwin-x86_64.tar.gz
  tar xzf cmake-${CMAKE_VERSION}-Darwin-x86_64
  cd cmake-${CMAKE_VERSION}-Darwin-x86_64/CMake.app/Contents
  sudo mv bin/cmake /usr/local/bin/
  sudo mv share/cmake-${CMAKE_VERSION_MAJOR} /usr/local/share/
else
  echo "cmake@${CMAKE_VERSION} is already installed!"
fi

###
## Tmux
## https://github.com/tmux/tmux/releases

TMUX_VERSION_INSTALLED=$(tmux -V | head -n 1 | awk '{ print $2 }')
if [ "${TMUX_VERSION_INSTALLED}" != "${TMUX_VERSION}" ]
then
  cd $BUILD_DIR
  curl -vOL https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz
  tar xzf tmux-${TMUX_VERSION}.tar.gz
  cd tmux-${TMUX_VERSION}

  ./configure --prefix=${BUILD_PREFIX} \
    && make \
    && sudo make install \
    || exit 1
else
  echo "tmux@${TMUX_VERSION} is already installed!"
fi

###
## tmux-mem-cpu-load
## https://github.com/thewtex/tmux-mem-cpu-load/releases

TMUX_MCL_VERSION_INSTALLED=$(tmux-mem-cpu-load --help | head -n 1 | awk '{ print $2 }')
if [ "${TMUX_MCL_VERSION_INSTALLED}" != "v${TMUX_MCL_VERSION}" ]
then
  cd $BUILD_DIR
  curl -vOL https://github.com/thewtex/tmux-mem-cpu-load/archive/v${TMUX_MCL_VERSION}.tar.gz
  tar xzf v${TMUX_MCL_VERSION}.tar.gz
  cd tmux-mem-cpu-load-${TMUX_MCL_VERSION}

  cmake . \
    && make \
    && sudo make install \
    || exit 1
else
  echo "tmux-mem-cpu-load@${TMUX_MCL_VERSION} is already installed!"
fi

###
## libffi
## http://linuxfromscratch.org/blfs/view/svn/general/libffi.html

if [[ ! -d "/usr/local/lib/libffi-${LIBFFI_VERSION}" ]]
then
  cd $BUILD_DIR
  curl -vOL ftp://sourceware.org/pub/libffi/libffi-${LIBFFI_VERSION}.tar.gz
  tar xzf libffi-${LIBFFI_VERSION}.tar.gz
  cd libffi-${LIBFFI_VERSION}/

  ./configure --prefix=/usr/local --disable-static \
    && make \
    && sudo make install \
    || exit 1
else
  echo "libffi@${LIBFFI_VERSION} is already installed!"
fi

###
## gettext
## http://www.gnu.org/software/gettext/gettext.html

GETTEXT_VERSION_INSTALLED=$(gettext --version | head -n 1 | awk '{ print $NF }')
if [ "${GETTEXT_VERSION_INSTALLED}" != "${GETTEXT_VERSION}" ]
then
  cd $BUILD_DIR
  curl -vOL http://ftp.gnu.org/pub/gnu/gettext/gettext-${GETTEXT_VERSION}.tar.xz
  tar xzf gettext-${GETTEXT_VERSION}.tar.xz
  cd gettext-${GETTEXT_VERSION}/

  ./configure --prefix=/usr/local \
    && make \
    && sudo make install \
    || exit 1

  gettext --version
else
  echo "gettext@${GETTEXT_VERSION} is already installed!"
fi

###
## pcre
## http://pcre.org/

PCRE_VERSION_INSTALLED=$(pcre-config --version | head -n 1 | awk '{ print $NF }')
if [ "${PCRE_VERSION_INSTALLED}" != "${PCRE_VERSION}" ]
then
  cd $BUILD_DIR
  curl -vOL ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-${PCRE_VERSION}.tar.gz
  tar xzf pcre-${PCRE_VERSION}.tar.gz
  cd pcre-${PCRE_VERSION}/

  ./configure --prefix=/usr/local --enable-unicode-properties \
    && make \
    && sudo make install \
    || exit 1

  pcre-config --version
else
  echo "pcre-config@${PCRE_VERSION} is already installed!"
fi

###
## glib
## http://ftp.gnome.org/pub/GNOME/sources/glib/

GLIB_VERSION_INSTALLED=${GLIB_VERSION} # @TODO FIX-ME
if [ "${GLIB_VERSION_INSTALLED}" != "${GLIB_VERSION}" ]
then
  cd $BUILD_DIR
  curl -vOL http://ftp.gnome.org/pub/GNOME/sources/glib/${GLIB_VERSION_MAJOR}/glib-${GLIB_VERSION}.tar.xz
  tar xzf glib-2.49.1.tar.xz
  cd glib-2.49.1/

  ./configure --prefix=/usr/local \
    && make \
    && sudo make install \
    || exit 1
else
  echo "glib@${GLIB_VERSION} is already installed!"
fi

###
## neovim
## https://github.com/neovim/neovim/wiki/Building-Neovim#optimized-builds

NEOVIM_VERSION_INSTALLED=$(nvim --version | head -n 1 | awk '{ print $NF }')
if [ "${NEOVIM_VERSION_INSTALLED}" != "v${NEOVIM_VERSION}" ]
then
  cd $BUILD_DIR
  curl -vOL https://github.com/neovim/neovim/archive/v${NEOVIM_VERSION}.tar.gz
  tar xzf v${NEOVIM_VERSION}.tar.gz
  cd neovim-${NEOVIM_VERSION}

  make CMAKE_BUILD_TYPE=Release \
    && sudo make install \
    || exit 1
else
  echo "neovim@${NEOVIM_VERSION} is already installed!"
fi

###
## fzf
## https://github.com/junegunn/fzf

FZF_VERSION_INSTALLED=$(fzf --version)
if [ "${FZF_VERSION_INSTALLED}" != "${FZF_VERSION}" ]
then
  cd $BUILD_DIR
  curl -vOL https://github.com/junegunn/fzf/archive/${FZF_VERSION}.tar.gz
  tar xzf ${FZF_VERSION}.tar.gz
  cd fzf-${FZF_VERSION}

  ./install \
    || exit 1

  mv shell/key-bindings.fish ~/.config/fish/functions/fzf_key_bindings.fish

  sudo mv bin/fzf-${FZF_VERSION}-darwin_amd64 /usr/local/bin/fzf
  sudo mv bin/fzf-tmux /usr/local/bin
else
  echo "fzf@${FZF_VERSION} is already installed!"
fi


###
## pastboard
## https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard

PASTEBOARD_VERSION_INSTALLED=$(reattach-to-user-namespace --version | head -n 1 | awk '{ print $NF }')
if [ "${PASTEBOARD_VERSION_INSTALLED}" != ${PASTEBOARD_VERSION} ]
then
  cd $BUILD_DIR
  curl -vOL "https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard/archive/v${PASTEBOARD_VERSION}.tar.gz"
  tar xzf "v${PASTEBOARD_VERSION}.tar.gz"
  cd "tmux-MacOSX-pasteboard-${PASTEBOARD_VERSION}"

  make || exit 1
  sudo cp reattach-to-user-namespace /usr/local/bin
else
  echo "pasteboard@${PASTEBOARD_VERSION} is already installed!"

fi
