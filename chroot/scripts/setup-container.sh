#!/bin/bash
set -e

emaint sync

eselect profile set "default/linux/amd64/23.0/desktop/plasma/systemd"

emerge --ask app-eselect/eselect-repository

eselect repository remove -f gentoo
eselect repository add gentoo git "https://github.com/gentoo-mirror/gentoo"
rm -rv /var/db/repos/gentoo
emaint -r gentoo sync


emerge --ask --update --with-bdeps=y --newuse --deep --changed-use @world

emerge --ask \
    www-servers/nginx \
    app-portage/gentoolkit \
    app-eselect/eselect-repository

systemctl enable --now nginx
systemctl enable --now rsyncd