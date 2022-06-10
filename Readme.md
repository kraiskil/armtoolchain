# Compile script for a cross arm-none-eabi GCC

These scripts compile a arm-none-eabi GNU C and C++ compiler.

This targets bare-metal ARM Cortex M (and possibly similar) microcontrollers.

## Usage
Modify run.sh for install directory and run it.
No checks of available tools are made, so those need to be installed
seprately. At least a recent C++ compiler is needed.

## Why?
Ubuntu ships with a arm-none-eabi-gcc, but not a gdb.

The [binaries provided by ARM](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/downloads)
are linked against some old python version that was shipped with Ubuntu 18.04LTS (not out of date yet, but there
has been two LTS releases since, and that version of python is nolonger even available for download on python.org). 

## Kudos
The scripts are ported from the [PS3toolchain scripts](https://github.com/ps3dev/ps3toolchain).
Only minimal cosmetic updates were needed.
