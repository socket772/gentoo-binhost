FROM gentoo/stage3:systemd-20260209

# Sincronizzazione iniziale
RUN emaint sync --auto

# Installazione Nginx e tool base
RUN emerge --oneshot --autounmask=y --autounmask-continue \
    www-servers/nginx \
    app-portage/gentoolkit \
    app-misc/mime-types

# Creiamo la directory dei pacchetti
RUN mkdir -p "/var/www/binhost" "/run/nginx/" "/etc/portage/package.env"

# Copiamo la configurazione Nginx
COPY "nginx.conf" "/etc/nginx/nginx.conf"

RUN chown -R nginx:nginx "/run/nginx" "/var/log/nginx"

# Impostiamo il profilo corretto (Plasma + Systemd)
# Questo è il profilo stabile attuale per Plasma 6
RUN eselect profile set "default/linux/amd64/23.0/desktop/plasma/systemd"

# Esponiamo la porta
EXPOSE 80

# Verifica sintassi Nginx durante la build
RUN nginx -t

# Avvio Nginx
CMD ["nginx", "-g", "daemon off;"]