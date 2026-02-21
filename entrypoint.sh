#!/bin/bash
set -eu

CHROOT_DIR="/mnt/gentoo"

# Associa la funzione cleanup ai segnali di terminazione
trap cleanup_mounts SIGINT SIGTERM

# https://distfiles.gentoo.org/releases/amd64/autobuilds/20260215T164556Z/stage3-amd64-systemd-20260215T164556Z.tar.xz

# Scarico lo stage 3 di gentoo se non esiste
# anche se è vecchio non è in problema, serve solo la prima volta
# Cambialo se non essite più il file
wget --no-clobber "https://distfiles.gentoo.org/releases/amd64/autobuilds/20260215T164556Z/stage3-amd64-systemd-20260215T164556Z.tar.xz" -P /stage3-cache -O stage3.tar.xz

if [ "$(ls -A $CHROOT_DIR)" ]; then
    echo "La cartella non e vuota. evito la configurazione della chroot"
else
    # Configura la chroot
    echo "Estraggo lo stage 3 nella chroot"
    tar xpvf stage3.tar.xz --xattrs-include='*.*' --numeric-owner -C "$CHROOT_DIR"

    echo "copio le info di connessione alla rete"
    cp -v --dereference /etc/resolv.conf /mnt/gentoo/etc/

    cp -v "/chroot" ""
fi

echo "monto i fs per la chroot"
mount --bind /proc "$CHROOT_DIR/proc"
mount --bind /sys "$CHROOT_DIR/sys"
mount --bind /dev "$CHROOT_DIR/dev"
mount --bind /run "$CHROOT_DIR/run"
mount --bind /tmp "$CHROOT_DIR/tmp"

chroot "$CHROOT_DIR/" "$CHROOT_DIR/scripts/chroot-script"

exit 0

# shellcheck disable=SC2329
cleanup_mounts() {
    umount -l /mnt/gentoo/dev{/shm,/pts,}
    umount -R /mnt/gentoo
    exit 0
}