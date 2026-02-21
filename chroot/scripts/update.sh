#!/bin/bash
set -e

emaint sync --auto

emerge --update --deep --changed-use --newuse --ask --with-bdeps=y @world

emaint binhost --fix
