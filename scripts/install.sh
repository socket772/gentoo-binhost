#!/bin/bash
set -e

emerge --ask --update --with-bdeps=y --newuse --deep --changed-use @world

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
    kde-plasma/plasma-meta \
    kde-apps/kde-apps-meta \
    app-admin/keepassxc \
    app-admin/sudo \
    app-shells/zsh \
    app-shells/zsh-completions \
    app-shells/gentoo-zsh-completions \
    dev-vcs/git

emaint binhost --fix
