FROM gentoo/stage3:systemd-20260209

COPY "./configs/make.conf" "/etc/portage/make.conf"

# Installiamo i tool di base necessari per gestire il binhost
RUN emaint sync --auto
RUN emerge -q --autounmask=y --autounmask-continue \
    www-servers/nginx \
    app-eselect/eselect-repository \
    app-portage/gentoolkit \
    dev-vcs/git

# Creiamo le cartelle necessarie per i log e per il PID file
# e assegniamo la proprietà all'utente nginx
RUN mkdir -p \
    "/run/nginx" \
    "/var/log/nginx" \
    "/binhost" \
    "/usr/local/bin" \
    "/var/log/portage" \
    "/binhost/var/cache/binpkgs" \
    "/binhost/var/log/portage" \
    "/etc/portage/repos.conf"

RUN chown -R portage:portage "/binhost/var/cache/binpkgs"
RUN chown -R portage:portage "/binhost/var/log/portage"
RUN chown -R portage:portage "/var/log/portage"

RUN chown -R nginx:nginx "/run/nginx" "/var/log/nginx"

# Aggiungo i file stage3 di gentoo
ADD "https://distfiles.gentoo.org/releases/amd64/autobuilds/20260208T163056Z/stage3-amd64-systemd-20260208T163056Z.tar.xz" "/stage3.tar.xz"

# Estraggo lo stage 3
RUN tar --extract --preserve-permissions --file "stage3.tar.xz" --xattrs-include='*.*' --exclude='dev/*' --numeric-owner --directory "/binhost"

# Verifica sintassi Nginx durante la build
RUN nginx -t

# Esponiamo la porta per Nginx
EXPOSE 80

# Comando di default: avvia Nginx.
# La compilazione la lanceremo manualmente o via exec per non bloccare l'avvio.
CMD ["nginx", "-g", "daemon off;"]
