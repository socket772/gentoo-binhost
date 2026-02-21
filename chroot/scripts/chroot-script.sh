#!/bin/bash

# imposta come repository github per evitare il ban da gentoo
echo "Cambio il repository"
eselect repository remove -f gentoo
eselect repository add gentoo git "https://github.com/gentoo-mirror/gentoo"
emaint -r gentoo sync

# Imposta il profilo
echo "Imposto il profilo"
eselect profile set "default/linux/amd64/23.0/desktop/plasma/systemd"

# Installa i pacchetti fondamentali per il binhost
echo "Installo nginx"
emerge --jobs=5 \
    www-servers/nginx \
    app-portage/gentoolkit \
    sys-apps/proot

# Cambia il proprietario per le cartelle di nginx
chown -R nginx:nginx "/run/nginx" "/var/log/nginx"

# Avvia il daemon di rsync
echo "Avvio rsyncd"
rsync --daemon --config="/etc/rsyncd.conf"

# Avvia il server di nginx
echo "Avvio nginx"
nginx -g "daemon off;";

# Evita la chiusura del container creando un processo infinito a costo 0 sulla cpu
echo "Sistema pronto. Entra con: docker exec -it binhost bash"
exec tail -f /dev/null