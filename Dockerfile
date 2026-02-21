FROM gentoo/stage3:amd64-desktop-systemd

RUN mkdir -p "/stage3-cache" "/custom-configs"

# Copio l'entrypoint di docker
COPY "./entrypoint.sh" "/entrypoint.sh"

# Esponiamo la porta di nginx e rsyncd
EXPOSE 80
EXPOSE 873

ENTRYPOINT [ "/entrypoint.sh" ]

# CMD ["tail", "-f", "/dev/null"]