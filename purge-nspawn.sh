#!/bin/bash

# Nome del container
MACHINE="gentoo-binhost"

echo "=== Inizio pulizia nspawn per: ${MACHINE} ==="

# 1. Ferma il servizio se attivo
if systemctl is-active --quiet "${MACHINE}.service"; then
    echo "[*] Fermando il servizio systemd..."
    sudo systemctl stop "${MACHINE}.service"
fi

# 2. Termina la macchina tramite machinectl
if machinectl list | grep -q "${MACHINE}"; then
    echo "[*] Terminazione macchina via machinectl..."
    sudo machinectl terminate "${MACHINE}"
    sleep 2
fi

# 3. Uccidi eventuali processi residui usando pgrep
# -f: cerca nell'intera riga di comando (full)
# -d: delimiter (spazio) per ottenere una lista di PID
PIDS=$(pgrep -f "systemd-nspawn.*${MACHINE}")

if [ -n "${PIDS}" ]; then
    echo "[*] Uccisione processi nspawn residui (PIDs: ${PIDS})..."
    # shellcheck disable=SC2086
    sudo kill -9 ${PIDS}
fi

# 4. Rimuovi interfacce di rete virtuali appese
VETH_INTERFACES=$(ip link show | grep -o "ve-${MACHINE}[^@ ]*")
for iface in $VETH_INTERFACES; do
    echo "[*] Rimuovendo interfaccia di rete orfana: ${iface}"
    sudo ip link delete "${iface}"
done

# 5. Reset database macchine
echo "[*] Reset database macchine..."
sudo systemctl restart systemd-machined

echo "Cancella la cartella del binhost"
sudo rm -rv /var/lib/machines/gentoo-binhost
sudo rm -v /etc/systemd/nspawn/gentoo-binhost.nspawn

echo "=== Pulizia completata per ${MACHINE} ==="