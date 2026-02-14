FROM gentoo/stage3:amd64-desktop-systemd

# Sincronizzazione iniziale
RUN emaint sync --auto

# Installazione Nginx e tool base
RUN emerge --oneshot --autounmask=y --jobs=5 --autounmask-continue \
    www-servers/nginx \
    app-portage/gentoolkit \
    app-misc/mime-types \
    dev-libs/elfutils

# Creiamo la directory dei pacchetti
RUN mkdir -p "/var/www/binhost" "/run/nginx/" "/etc/portage/package.env" "/etc/kernel/config.d"

# Copiamo la configurazione Nginx
COPY "nginx.conf" "/etc/nginx/nginx.conf"

COPY "./rsyncd.conf" "/etc/rsyncd.conf"

COPY "./entrypoint.sh" "/usr/local/bin/entrypoint.sh"

RUN chown -R nginx:nginx "/run/nginx" "/var/log/nginx"

# Impostiamo il profilo corretto (Plasma + Systemd)
# Questo è il profilo stabile attuale per Plasma 6
# RUN eselect profile set "default/linux/amd64/23.0/desktop/plasma/systemd"

# Abilita il daemon di rsyncd
RUN systemctl enable --now rsyncd.service

# Esponiamo la porta di nginx e rsyncd
EXPOSE 80
EXPOSE 873

# Verifica sintassi Nginx durante la build
RUN nginx -t

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ] 