#!/bin/bash

# Avvia il daemon di rsync
echo "Avvio rsyncd"
rsync --daemon --config="/etc/rsyncd.conf"

# Avvia il server di nginx
echo "Avvio nginx"
nginx -g "daemon off;";