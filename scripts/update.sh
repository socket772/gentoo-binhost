#!/bin/bash
set -e

emaint sync --auto

emerge --update --deep --changed-use --newuse --ask --with-bdeps=y @world

eselect kernel set 1

cd /usr/src/linux

# make defconfig

make clean

make modules_prepare

emaint binhost --fix
