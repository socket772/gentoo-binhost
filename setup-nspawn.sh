#!/bin/bash
set -eu

# --- CONFIGURAZIONE NON CAMBIARLE, ALTRIMENTI purge-nspawn.sh FALLIRA ---
DEST_DIR="/var/lib/machines/gentoo-binhost"
TEMP_DIR="/tmp/gentoo-download"
BASE_URL="https://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64-systemd/"

# 1. Recupero info (Utente normale)
echo "Recupero informazioni sull'ultimo Stage 3..."
STAGE3_FILE=$(curl -s "$BASE_URL" | grep -oP 'stage3-amd64-systemd-\d+T\d+Z\.tar\.xz' | sort -r | head -n 1)
URL="${BASE_URL}${STAGE3_FILE}"

# 2. Download e Verifica (Utente normale)
mkdir -p "$TEMP_DIR"
cd "$TEMP_DIR"

echo "Download di $STAGE3_FILE in corso"
wget --no-clobber --show-progress "$URL"

# 3. Estrazione (Richiede privilegi elevati)
echo "--- Richiesta privilegi per l'estrazione in $DEST_DIR ---"
sudo mkdir -p "$DEST_DIR"

# Usiamo sudo solo per tar, leggendo il file scaricato dall'utente normale
sudo tar xpvf "$TEMP_DIR/$STAGE3_FILE" --xattrs-include='*.*' --numeric-owner -C "$DEST_DIR"

# 4. Pulizia (Utente normale)
echo "Pulizia file temporanei..."
rm -rf "$TEMP_DIR"

# 5. Copio le configurazioni
echo "Copio le configurazioni"
sudo mkdir -p "$DEST_DIR"
sudo rsync -rvp --no-perms --no-owner --no-group "./chroot/" "$DEST_DIR/"
sudo mkdir -p "/etc/systemd/nspawn/"
sudo install -m 644 -o root -g root "./gentoo-binhost.nspawn" "/etc/systemd/nspawn/"
sudo install -m 644 -o root -g root "./99-unmanaged-devices.conf" "/etc/NetworkManager/conf.d/"

# Configuro il machine-id
echo "Configuro il machine-id"
sudo systemd-machine-id-setup --root="$DEST_DIR"

# Avvia automaticamente il container
echo "Avvia automaticamente il container"
sudo machinectl enable gentoo-binhost

echo "--- Installazione completata ---"
