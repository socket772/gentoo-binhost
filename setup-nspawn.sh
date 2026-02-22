#!/bin/bash
set -eu

ORIGINAL_DIR=$(pwd)

# --- CONFIGURAZIONE ---
MACHINE_NAME="gentoo-binhost"
DEST_DIR="/var/lib/machines/$MACHINE_NAME"
TEMP_DIR="/tmp/gentoo-download"
BASE_URL="https://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64-systemd/"

# 1. Recupero info (Utente normale)
echo "Recupero informazioni sull'ultimo Stage 3..."
STAGE3_FILE=$(curl -s "$BASE_URL" | grep -oP 'stage3-amd64-systemd-\d+T\d+Z\.tar\.xz' | tail -n 1)
SHA256_FILE="$STAGE3_FILE.sha256"
URL="${BASE_URL}${STAGE3_FILE}"

# 2. Download e Verifica (Utente normale)
mkdir -p "$TEMP_DIR"
cd "$TEMP_DIR"

echo "Download di $STAGE3_FILE in corso"
wget -q --no-clobber --show-progress "$URL"
wget -q --no-clobber --show-progress "${URL}.sha256"

echo "Verifica integrità SHA512..."
cd "$TEMP_DIR"
if sha256sum --ignore-missing -c --warn --status "./$SHA256_FILE"; then
    echo "Verifica integrità: OK"
else
    echo "ERRORE: Hash non corrispondente!"
    rm -rf "$TEMP_DIR"
    exit 1
fi
cd "$ORIGINAL_DIR"

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
sudo rsync -rvp --no-perms --no-owner --no-group "./chroot/" "$DEST_DIR/"
sudo mkdir -p "/etc/systemd/nspawn/"
sudo rsync -v --chmod=D755,F755 "./binhost.nspawn" "/etc/systemd/nspawn/"

echo "--- Installazione completata ---"