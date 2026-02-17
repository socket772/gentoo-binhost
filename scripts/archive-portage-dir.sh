#!/bin/bash

rm -v "/var/www/binhost/_custom-files/Archive.tar"

tar -cvf "/var/www/binhost/_custom-files/Archive.tar" "/etc/portage/"