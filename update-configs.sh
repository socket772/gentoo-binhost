#!/bin/bash
set -ue

sudo machinectl stop gentoo-binhost

while sudo machinectl list | grep -q "gentoo-binhost"; do
    echo "Attendendo lo spegnimento completo..."
    sleep 1
done

sudo rsync -rvp --no-perms --no-owner --no-group "./chroot/" "/var/lib/machines/gentoo-binhost/"

sudo install -v -m 644 -o root -g root "./gentoo-binhost.nspawn" "/etc/systemd/nspawn/"

sudo machinectl start gentoo-binhost