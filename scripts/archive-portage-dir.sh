#!/bin/bash

rm -v "/var/www/binhost/_custom-files/Archive.tar"

tar -cvf "/var/www/binhost/_custom-files/Archive.tar" "/etc/portage/"

cp -v /etc/portage/make.conf /var/www/binhost/_custom-files/
cp -v /etc/portage/package.use/localuseflags /var/www/binhost/_custom-files/