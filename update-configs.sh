#!/bin/bash
set -e

sudo machinectl stop gentoo-binhost

sudo rsync -rvp --no-perms --no-owner --no-group "./chroot/" "$DEST_DIR/"

sudo install -m 644 -o root -g root "./gentoo-binhost.nspawn" "/etc/systemd/nspawn/"
sudo install -m 644 -o root -g root "./99-unmanaged-devices.conf" "/etc/NetworkManager/conf.d/"

sudo machinectl start gentoo-binhost