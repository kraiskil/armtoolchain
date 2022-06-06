#!/bin/sh -e
# Build arm-none-eabi binutils
# Take INSTALL_DIR from environment.
#
# Derived from:
# gcc-newlib-PPU.sh by Naomi Peori (naomi@peori.ca)

GCC="gcc-12.1.0"
NEWLIB="newlib-4.1.0"


if [ ! -d ${GCC} ]; then

  ## Download the source code.
  if [ ! -f ${GCC}.tar.xz ]; then wget --continue https://ftp.gnu.org/gnu/gcc/${GCC}/${GCC}.tar.xz; fi
  if [ ! -f ${NEWLIB}.tar.gz ]; then wget --continue https://sourceware.org/pub/newlib/${NEWLIB}.tar.gz; fi

  ## Unpack the source code.
  rm -Rf ${GCC} && tar xfvJ ${GCC}.tar.xz
  rm -Rf ${NEWLIB} && tar xfvz ${NEWLIB}.tar.gz

  ## Enter the source code directory.
  cd ${GCC}

  ## Create the newlib symlinks.
  ln -s ../${NEWLIB}/newlib newlib
  ln -s ../${NEWLIB}/libgloss libgloss

  ## Download the prerequisites.
  ./contrib/download_prerequisites

  ## Leave the source code directory.
  cd ..

fi

if [ ! -d ${GCC}/build ]; then

  ## Create the build directory.
  mkdir ${GCC}/build

fi

## Enter the build directory.
cd ${GCC}/build

## Configure the build.
CFLAGS_FOR_TARGET="-O4 -ffast-math -ftree-vectorize -funroll-loops -D_IEEE_LIBM" \
../configure --prefix="$INSTALL_DIR" --target="arm-none-eabi" \
    --disable-dependency-tracking \
    --disable-libcc1 \
    --disable-libstdcxx-pch \
    --disable-multilib \
    --disable-nls \
    --disable-shared \
    --disable-win32-registry \
    --enable-languages="c,c++" \
    --enable-lto \
    --enable-threads \
    --with-newlib \
    --enable-newlib-multithread \
    --enable-newlib-hw-fp \
    --with-system-zlib

## Compile and install.
make -j
make install
