#!/bin/bash
set -e

# emerge --ask --update --with-bdeps=y --newuse --deep --changed-use @world

emerge --ask --noreplace \
    app-admin/keepassxc \
    app-admin/sudo \
    app-arch/7zip \
    app-arch/unzip \
    app-arch/unzip \
    app-arch/xz-utils \
    app-arch/zip \
    app-arch/zstd \
    app-editors/vscodium \
    app-misc/fastfetch \
    app-misc/tmux \
    app-office/libreoffice \
    app-shells/gentoo-zsh-completions \
    app-shells/zsh \
    app-shells/zsh \
    app-shells/zsh-completions \
    dev-games/godot \
    dev-lang/go \
    dev-libs/json-c \
    dev-libs/openssl \
    dev-vcs/git \
    kde-apps/ark \
    kde-apps/dolphin \
    kde-apps/dolphin-plugins-common \
    kde-apps/dolphin-plugins-git \
    kde-apps/dolphin-plugins-mercurial \
    kde-apps/dolphin-plugins-subversion \
    kde-apps/filelight \
    kde-apps/gwenview \
    kde-apps/kalarm \
    kde-apps/kamera \
    kde-apps/kamoso \
    kde-apps/kate \
    kde-apps/kcolorchooser \
    kde-apps/kcron \
    kde-apps/kfind \
    kde-apps/kolourpaint \
    kde-apps/kompare \
    kde-apps/ktimer \
    kde-apps/okular \
    kde-plasma/plasma-meta \
    mail-client/thunderbird \
    media-video/vlc \
    net-misc/dhcpcd \
    net-misc/yt-dlp \
    net-wireless/iw \
    net-wireless/wpa_supplicant \
    sys-apps/dmidecode \
    sys-apps/flatpak \
    sys-apps/fwupd \
    sys-apps/pciutils \
    sys-apps/ripgrep \
    sys-apps/systemd \
    sys-apps/zram-generator \
    sys-block/io-scheduler-udev-rules \
    sys-block/partitionmanager \
    sys-fs/android-file-transfer-linux \
    sys-fs/btrfs-progs \
    sys-fs/dosfstools \
    sys-fs/e2fsprogs \
    sys-fs/ntfs3g \
    sys-kernel/gentoo-kernel \
    sys-kernel/linux-firmware \
    sys-kernel/modprobed-db \
    sys-process/htop \
    www-client/librewolf

emaint binhost --fix
