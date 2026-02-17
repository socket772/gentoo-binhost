#!/bin/bash
set -e

emerge --ask --update --with-bdeps=y --newuse --changed-use @world

emerge --ask \
    sys-kernel/gentoo-kernel \
    sys-kernel/linux-firmware \
    sys-kernel/modprobed-db \
    sys-fs/xfsprogs \
    sys-fs/e2fsprogs \
    sys-fs/dosfstools \
    sys-fs/btrfs-progs \
    sys-fs/f2fs-tools \
    sys-fs/ntfs3g \
    sys-block/io-scheduler-udev-rules \
    net-wireless/iw \
    net-wireless/wpa_supplicant \
    dev-lang/go \
    sys-apps/dmidecode \
    sys-apps/fwupd \
    sys-apps/pciutils \
    net-misc/dhcpcd \
    dev-libs/openssl \
    sys-apps/flatpak \
    app-misc/fastfetch \
    dev-libs/json-c \
    sys-apps/systemd \
    kde-plasma/plasma-meta

# emerge kde-plasma/plasma-meta \
#     sys-apps/ripgrep net-fs/nfs-utils \
#     media-libs/tiff \
#     net-fs/samba \
#     sys-apps/dmidecode \
#     app-text/aha \
#     sys-apps/fwupd \
#     sys-apps/pciutils \
#     dev-util/vulkan-tools \
#     app-misc/wayland-utils \
#     dev-libs/wayland \
#     sys-apps/mlocate \
#     sys-apps/flatpak \
#     dev-libs/elfutils \
#     media-libs/libpulse \
#     dev-db/mariadb-connector-c
    

# eselect kernel set 1

# cd /usr/src/linux

# make defconfig

# make clean

# make modules_prepare

emaint binhost --fix
