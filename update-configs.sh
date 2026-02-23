#!/bin/bash

sudo machinectl stop gentoo-binhost

sudo rsync -rvp --no-perms --no-owner --no-group "./chroot/" "$DEST_DIR/"

sudo install -v -m 644 -o root -g root "./gentoo-binhost.nspawn" "/etc/systemd/nspawn/"
