#!/bin/bash
# UPDATE_BINHOST.SH - Il cuore del builder

# # Carica le variabili se non sono nel Dockerfile
# export CCACHE_DIR="/var/cache/ccache"
# export PATH="/usr/lib/ccache/bin:${PATH}"

echo ">>> Inizio aggiornamento pacchetti (@world)..."
# -u: update, -D: deep, -N: newuse, -v: verbose
# -k: usa binari se esistenti, -b: crea binari dai nuovi pacchetti
emerge -uDNavbk --with-bdeps=y @world

echo ">>> Aggiornamento configurazioni..."
etc-update --automode -5

echo ">>> Pulizia pacchetti obsoleti e dipendenze inutilizzate..."
emerge --depclean

echo ">>> Rimozione vecchi pacchetti binari..."
eclean-pkg
