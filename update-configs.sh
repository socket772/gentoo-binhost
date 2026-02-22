#!/bin/bash
set -e

sudo rsync -rvp --no-perms --no-owner --no-group "./chroot/" "$DEST_DIR/"