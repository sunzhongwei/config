#!/bin/bash

# ----------------------------------------
# DESCRIPTION
# init webpy app
# ----------------------------------------
set -e	# or use "set -o errexit" to quit on error.
set -x  # or use "set -o xtrace" to print the statement before you execute it.

cp ~/Templates/webpy/webpy.py ./main.py
cp ~/Templates/webpy/start.sh ./start.sh
cp ~/Templates/webpy/nginx_site.conf ./$LOCAL_SITE_CONF

echo "Done."
