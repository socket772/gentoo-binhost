#!/bin/bash
# SETUP_BINHOST.SH - Da eseguire una tantum o dopo modifiche al make.conf

echo ">>> Sincronizzazione repository..."
emerge --sync

echo ">>> Installo i pacchetti"
ROOT="/binhost" PORTAGE_CONFIGROOT="/binhost" PKGDIR="/binhost/var/cache/binpkgs/" emerge -uDdN --buildpkg --usepkg --keep-going -j4 --root-deps --with-bdeps=y \
    @world \
    kde-plasma/plasma-meta \
    kde-apps/kde-apps-meta \
    sys-kernel/gentoo-kernel-bin \
    sys-block/io-scheduler-udev-rules \
    net-wireless/iw net-wireless/wpa_supplicant \
    net-misc/dhcpcd \
    sys-fs/dosfstools \
    sys-fs/btrfs-progs \
    sys-fs/ntfs3g \
    sys-fs/e2fsprogs \
    sys-apps/systemd-utils \
    sys-apps/systemd


echo ">>> Rigenero l'indice"
emaint binhost --fix