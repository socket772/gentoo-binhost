#!/bin/bash
set -e

emerge --update --deep --newuse --changed-use --ask @world \
    kde-plasma/plasma-meta \
    sys-apps/ripgrep net-fs/nfs-utils \
    net-fs/samba \
    sys-apps/dmidecode \
    app-text/aha \
    sys-apps/fwupd \
    sys-apps/pciutils \
    dev-util/vulkan-tools \
    app-misc/wayland-utils \
    dev-libs/wayland \
    sys-apps/mlocate \
    sys-fs/e2fsprogs \
    sys-fs/dosfstools \
    sys-fs/btrfs-progs \
    sys-fs/ntfs3g \
    sys-block/io-scheduler-udev-rules \
    net-misc/dhcpcd \
    net-wireless/iw \
    net-wireless/wpa_supplicant \
    sys-kernel/linux-firmware \
    sys-kernel/installkernel \
    sys-kernel/gentoo-kernel \
    sys-apps/flatpak \
    sys-kernel/gentoo-sources \
    dev-libs/elfutils \
    dev-libs/openssl

eselect kernel set 1

cd /usr/src/linux

# make defconfig

make clean

make modules_prepare

emaint binhost --fix
