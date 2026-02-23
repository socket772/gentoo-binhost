#!/bin/bash
set -e
emaint sync

emerge --ask app-eselect/eselect-repository

eselect profile set "default/linux/amd64/23.0/desktop/plasma/systemd"

eselect repository remove -f gentoo
eselect repository add gentoo git "https://github.com/gentoo-mirror/gentoo"
rm -rv /var/db/repos/gentoo
emaint -r gentoo sync

emerge --ask --update --with-bdeps=y --newuse --deep --changed-use @world

emerge --ask \
    www-servers/nginx \
    app-portage/gentoolkit

mkdir -p "/run/nginx" "/var/www/binhost"

chown nginx:nginx "/run/nginx"

systemctl enable --now nginx
systemctl enable --now git-daemon