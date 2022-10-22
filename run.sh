#!/bin/bash -e

INSTALL_DIR=/opt/gcc/arm-none-eabi-12.1/
export PATH=$INSTALL_DIR/bin:$PATH
export MAKE_FLAGS=-j4

./scripts/001-binutils.sh 
./scripts/002-gcc-newlib.sh
./scripts/003-gdb.sh
./scripts/004-picolib.sh


