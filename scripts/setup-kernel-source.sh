#!/bin/bash
set -e

eselect kernel set 1

cd /usr/src/linux

make clean

# make defconfig

make modules_prepare