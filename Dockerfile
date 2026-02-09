FROM gentoo/stage3:systemd-20260209

# Sovrascrive il PATH includendo i binari di ccache all'inizio
# Nota: in Docker usiamo semplicemente :${PATH}
ENV PATH="/usr/lib/ccache/bin:${PATH}"

# Installiamo i tool di base necessari per gestire il binhost
RUN emerge-webrsync && \
    emerge -q --autounmask=y --autounmask-continue \
    www-servers/nginx \
    app-eselect/eselect-repository \
    app-portage/gentoolkit \
    dev-vcs/git \
    dev-util/ccache

# Creiamo le cartelle necessarie per i log e per il PID file
# e assegniamo la proprietà all'utente nginx
RUN mkdir -p /run/nginx /var/log/nginx && \
    chown -R nginx:nginx /run/nginx /var/log/nginx

# Aggiungo i file stage3 di gentoo
ADD "https://distfiles.gentoo.org/releases/amd64/autobuilds/20260208T163056Z/stage3-amd64-systemd-20260208T163056Z.tar.xz" "/stage3.tar.xz"

# Creiamo le directory per il binhost
RUN mkdir "/binhost"

# Estraggo lo stage 3
RUN tar --extract --preserve-permissions --file "stage3.tar.xz" --xattrs-include='*.*' --exclude='dev/*' --numeric-owner --directory "/binhost"

# Creo le cartelle dentro il target di chroot
RUN mkdir -p /var/cache/binpkgs /var/log/portage /var/cache/ccache
RUN chown -R portage:portage /var/cache/ccache

# Verifica sintassi Nginx durante la build
RUN nginx -t

# Esponiamo la porta per Nginx
EXPOSE 80

# Comando di default: avvia Nginx.
# La compilazione la lanceremo manualmente o via exec per non bloccare l'avvio.
CMD ["nginx", "-g", "daemon off;"]
