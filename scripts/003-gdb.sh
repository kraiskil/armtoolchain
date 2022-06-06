#!/bin/sh -e
# Build arm-none-eabi binutils
# Take INSTALL_DIR from environment.
#
# Derived from:
# gdb-PPU.sh by Naomi Peori (naomi@peori.ca)

GDB="gdb-12.1"

if [ ! -d ${GDB} ]; then

  ## Download the source code.
  if [ ! -f ${GDB}.tar.xz ]; then wget --continue https://ftp.gnu.org/gnu/gdb/${GDB}.tar.xz; fi

  ## Download an up-to-date config.guess and config.sub
  if [ ! -f config.guess ]; then wget --continue https://git.savannah.gnu.org/cgit/config.git/plain/config.guess; fi
  if [ ! -f config.sub ]; then wget --continue https://git.savannah.gnu.org/cgit/config.git/plain/config.sub; fi

  ## Unpack the source code.
  tar xf ${GDB}.tar.xz

  ## Replace config.guess and config.sub
  cp config.guess config.sub ${GDB}

fi

if [ ! -d ${GDB}/build ]; then

  ## Create the build directory.
  mkdir ${GDB}/build

fi

## Enter the build directory.
cd ${GDB}/build

## Configure the build.
../configure --prefix="$PS3DEV/$INSTALL_DIR" --target="arm-none-eabi" \
    --disable-multilib \
    --disable-nls \
    --disable-sim \
    --disable-werror

## Compile and install.
make -j
make install
