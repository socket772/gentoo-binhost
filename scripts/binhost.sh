#!/bin/bash
set -e

echo ">>> Sincronizzazione repository..."
emaint sync --auto

export ROOT="/binhost"
export PORTAGE_CONFIGROOT="/binhost"
export PKGDIR="/binhost/var/cache/binpkgs/"

eselect --root="/binhost" profile set "default/linux/amd64/23.0/desktop/plasma/systemd"

echo ">>> Installo i pacchetti"
emerge -uDN --buildpkg --usepkg --keep-going -j4 --root-deps \
    --with-bdeps=y --autounmask=y \
    --autounmask-backtrack=y --autounmask-continue \
    @world \
    kde-plasma/plasma-meta \
    kde-apps/kde-apps-meta \
    sys-kernel/gentoo-kernel-bin \
    sys-block/io-scheduler-udev-rules \
    net-wireless/iw \
    net-wireless/wpa_supplicant \
    net-misc/dhcpcd \
    sys-fs/dosfstools \
    sys-fs/btrfs-progs \
    sys-fs/ntfs3g \
    sys-fs/e2fsprogs \
    sys-apps/systemd-utils \
    sys-apps/systemd

etc-update --automode -5

echo ">>> Rigenero l'indice"
emaint binhost --fix
