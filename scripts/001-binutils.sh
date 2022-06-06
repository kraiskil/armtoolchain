#!/bin/sh -e
# Build arm-none-eabi binutils
# Take INSTALL_DIR from environment.
#
# Derived from:
# binutils-PPU.sh by Naomi Peori (naomi@peori.ca)

BINUTILS="binutils-2.38"

if [ ! -d ${BINUTILS} ]; then

  ## Download the source code.
  if [ ! -f ${BINUTILS}.tar.bz2 ]; then wget --continue https://ftp.gnu.org/gnu/binutils/${BINUTILS}.tar.bz2; fi

  ## Download an up-to-date config.guess and config.sub
  if [ ! -f config.guess ]; then wget --continue https://git.savannah.gnu.org/cgit/config.git/plain/config.guess; fi
  if [ ! -f config.sub ]; then wget --continue https://git.savannah.gnu.org/cgit/config.git/plain/config.sub; fi

  ## Unpack the source code.
  tar xfvj ${BINUTILS}.tar.bz2

  ## Replace config.guess and config.sub
  cp config.guess config.sub ${BINUTILS}

fi

if [ ! -d ${BINUTILS}/build ]; then

  ## Create the build directory.
  mkdir ${BINUTILS}/build

fi

## Enter the build directory.
cd ${BINUTILS}/build

## Configure the build.
../configure --prefix="$INSTALL_DIR" --target="arm-none-eabi" \
    --disable-nls \
    --disable-shared \
    --disable-debug \
    --disable-dependency-tracking \
    --disable-werror \
    --with-gcc \
    --with-gnu-as \
    --with-gnu-ld

## Compile and install.
make -j
make install
