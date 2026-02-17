#!/bin/bash

rm -v "/var/www/binhost/custom-files/Archive.tar"

tar -cvf "/var/www/binhost/custom-files/Archive.tar" "/etc/portage/"