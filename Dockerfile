FROM gentoo/stage3:amd64-desktop-systemd

# Creiamo la directory per i file di configurazione
RUN mkdir -p "/var/www/binhost" "/run/nginx/" "/etc/portage/package.env" "/etc/kernel/config.d" "/var/www/binhost/_custom-files" "/usr/local/bin/"

# Copio il package use (serve per nginx)
COPY "./package.use/" "/etc/portage/package.use/"

RUN eselect repository remove -f gentoo
RUN eselect repository add gentoo git "https://github.com/gentoo-mirror/gentoo"

# Sincronizzazione del database
RUN emaint -r gentoo sync

# Impostiamo il profilo corretto (Plasma + Systemd)
# Questo è il profilo stabile attuale per Plasma 6
RUN eselect profile set "default/linux/amd64/23.0/desktop/plasma/systemd"

# Installazione Nginx
RUN emerge --jobs=5 \
    www-servers/nginx \
    app-portage/gentoolkit


# Copio la configurazione del daemod di rsyncd
COPY "./rsyncd.conf" "/etc/rsyncd.conf"

# Copio l'entrypoint di docker
COPY "./entrypoint.sh" "/entrypoint.sh"

# Copiamo la configurazione Nginx
COPY "nginx.conf" "/etc/nginx/nginx.conf"

# Aggiungo la cartella dei log e PID di nginx
RUN chown -R nginx:nginx "/run/nginx" "/var/log/nginx"

# Esponiamo la porta di nginx e rsyncd
EXPOSE 80
EXPOSE 873

# Verifica sintassi Nginx durante la build
RUN nginx -t

# Avvio il container
ENTRYPOINT [ "/entrypoint.sh" ] 