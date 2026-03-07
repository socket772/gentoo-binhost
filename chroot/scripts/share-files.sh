#!/bin/bash

cp -fv /etc/portage/make.conf /var/www/binhost/_shared-files
cp -fv /etc/portage/package.use/localuseflags /var/www/binhost/_shared-files
cp -fv /etc/portage/package.accept_keywords/acceptkeywords /var/www/binhost/_shared-files
cp -fv /scripts/install.sh /var/www/binhost/_shared-files
