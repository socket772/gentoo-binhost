#!/bin/bash

echo ">>> Selezione profilo per kde plasma systemd gentoo"
eselect profile set "default/linux/amd64/23.0/desktop/plasma/systemd"

echo ">>> Sincronizzazione repository..."
emerge --sync

echo ">>> Lettura news importanti..."
eselect news read

echo ">>> Setup completato. Ora puoi lanciare update_binhost.sh"
