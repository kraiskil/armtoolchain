#!/bin/bash -e
#
# Build picolib, an alternative to the
# newlib built in script 002
# (this script is not from ps3tools)

wget -c https://github.com/picolibc/picolibc/archive/refs/heads/main.zip
rm -rf picolibc-main/
unzip -q main.zip
rm -rf  picolib_build
mkdir picolib_build
cd picolib_build
../picolibc-main/scripts/do-arm-configure -Dprefix=$INSTALL_DIR
ninja
ninja install

