#!/bin/bash

# ----------------------------------------
# DESCRIPTION
# sudo ./install.sh
# ----------------------------------------
set -e	# or use "set -o errexit" to quit on error.
set -x  # or use "set -o xtrace" to print the statement before you execute it.


# make sure use sudo
if [[ $EUID -ne 0 ]]; then
    echo "ERROR: Must be run with root privileges."
    exit 1
fi


# Webpy + Nginx with FastCGI
# http://webpy.org/cookbook/fastcgi-nginx
APTITUDE_OPTIONS="-y"
apt-get update
cat <<PACKAGES | xargs apt-get install $APTITUDE_OPTIONS
nginx
spawn-fcgi
python-flup
PACKAGES

cp nginx.conf /etc/nginx/nginx.conf

nginx -s reload


# in case spawn-fcgi child exited with 126
chmod +x main.py
