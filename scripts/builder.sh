#!/bin/bash
set -e

# 1. Aggiornamento dell'albero di Portage
echo "--> [CITADEL] Syncing Portage..."
emerge --sync

# 2. Impostazione del Profilo (KDE/Systemd 23.0)
# echo "--> [CITADEL] Setting Profile to desktop/plasma/systemd (23.0)..."
# eselect profile set default/linux/amd64/23.0/desktop/plasma/systemd

# 3. Aggiornamento e Compilazione
echo "--> [CITADEL] Starting Build Process..."

# Accetta automaticamente le modifiche alle USE flag suggerite da Portage
emerge --autounmask-write --autounmask-continue --ask=n kde-plasma/plasma-meta
etc-update --automode -5

# Compiliamo World + KDE Plasma Meta + KDE Apps
# --keep-going: Non fermarti se un singolo pacchetto fallisce
# --with-bdeps=y: Compila anche le dipendenze di build (fondamentale per binhost)
emerge -uDdN --usepkg --keep-going -j4 --verbose --with-bdeps=y \
    @world \
    kde-plasma/plasma-meta \
    kde-apps/kde-apps-meta \
    sys-kernel/gentoo-kernel-bin

# 4. Pulizia e Indicizzazione
# echo "--> [CITADEL] Cleaning old packages..."
# eclean-pkg -d
echo "--> [CITADEL] Regenerating Index..."
emaint binhost --fix

echo "--> [CITADEL] Done. Packages are ready."
