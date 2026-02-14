#!/bin/bash
set -e

eselect profile set default/linux/amd64/23.0/desktop/plasma/systemd

emerge --update --deep --newuse --changed-use --ask --with-bdeps=y --autounmask-backtrack=y \
    sys-kernel/gentoo-kernel

emerge --update --deep --newuse --changed-use --ask --with-bdeps=y --autounmask-backtrack=y @world \
    kde-plasma/plasma-meta \
    sys-apps/ripgrep net-fs/nfs-utils \
    media-libs/tiff \
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
    sys-apps/flatpak \
    dev-libs/elfutils \
    dev-libs/openssl \
    media-libs/libpulse \
    kde-plasma/xdg-desktop-portal-kde \
    sys-kernel/gentoo-sources
    

# eselect kernel set 1

# cd /usr/src/linux

# make defconfig

# make clean

# make modules_prepare

emaint binhost --fix
