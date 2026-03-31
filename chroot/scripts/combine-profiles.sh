#!/bin/bash

# Configurazione variabili
OVERLAY_DIR="/var/db/repos/local-custom"
REPO_NAME="local-custom"
PROFILE_SUBDIR="plasma-systemd-selinux"
PROFILE_PATH="${OVERLAY_DIR}/profiles/${PROFILE_SUBDIR}"
ARCH="amd64"
GENTOO_VER="23.0" # Verifica se la tua versione è 23.0 o 17.1

echo "--- Inizio creazione overlay: ${REPO_NAME} ---"

# 1. Creazione struttura directory
mkdir -p "${PROFILE_PATH}"
mkdir -p "${OVERLAY_DIR}/metadata"
mkdir -p "/etc/portage/repos.conf"

# 2. Definizione EAPI (Essenziale per Portage moderno)
echo "8" > "${OVERLAY_DIR}/profiles/eapi"

# 3. Nome del Repository
echo "${REPO_NAME}" > "${OVERLAY_DIR}/profiles/repo_name"

# 4. Metadata Layout
cat <<EOF > "${OVERLAY_DIR}/metadata/layout.conf"
masters = gentoo
profile-formats = portage-2
EOF

# 5. profiles.desc (L'entrata per eselect - impostata su stable)
# Formato: <arch> <percorso_profilo> <stato>
echo "${ARCH} ${PROFILE_SUBDIR} stable" > "${OVERLAY_DIR}/profiles/profiles.desc"

# 6. Definizione dei Parent (Ereditarietà)
# Nota: features/selinux aggiunge le flag SELinux al profilo desktop scelto
cat <<EOF > "${PROFILE_PATH}/parent"
gentoo:default/linux/${ARCH}/${GENTOO_VER}/desktop/plasma/systemd
gentoo:features/selinux
EOF

# 7. File opzionali ma consigliati per evitare errori di scansione
touch "${PROFILE_PATH}/make.defaults"
echo "true" > "${PROFILE_PATH}/packages"

# 8. Configurazione repos.conf per il sistema
cat <<EOF > "/etc/portage/repos.conf/${REPO_NAME}.conf"
[${REPO_NAME}]
location = ${OVERLAY_DIR}
masters = gentoo
auto-sync = no
priority = 50
EOF

echo "--- Configurazione completata! ---"
echo "Esegui ora: eselect profile list"
echo "Poi seleziona il tuo profilo stabile con: eselect profile set <numero>"