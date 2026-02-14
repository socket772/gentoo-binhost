#!/bin/bash
set -e

emerge --ask sys-kernel/gentoo-sources

cd /usr/src/linux

make clean

# make defconfig

cp /etc/kernel/config.d/full-config.conf /usr/src/linux/.config

# cp /usr/src/linux/.config /etc/kernel/config.d/full-config.conf

make modules_prepare