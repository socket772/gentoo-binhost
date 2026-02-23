#!/bin/bash
set -ue

DEST_DIR="/var/lib/machines/gentoo-binhost"

sudo machinectl stop gentoo-binhost

while sudo machinectl list | grep -q "gentoo-binhost"; do
    echo "Attendendo lo spegnimento completo..."
    sleep 1
done

sudo rsync -rvp --no-perms --no-owner --no-group "./chroot/" "$DEST_DIR/"

sudo install -v -m 644 -o root -g root "./gentoo-binhost.nspawn" "/etc/systemd/nspawn/"

sudo machinectl start gentoo-binhost