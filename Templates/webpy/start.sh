#!/bin/bash

# ----------------------------------------
# DESCRIPTION
#
# ----------------------------------------
set -x  # or use "set -o xtrace" to print the statement before you execute it.

MAIN_FILE_DIR=$(cd "$(dirname "$0")"; pwd)
MAIN_FILE="$MAIN_FILE_DIR/main.py"
NGINX_SITE_CONF="/usr/local/nginx/conf/sites-enabled/app.conf"
LOCAL_SITE_CONF="nginx_site.conf"
WAIT_SECONDS=3
PORT=8080

kill `pgrep -f "python $MAIN_FILE"`
echo "sleep $WAIT_SECONDS seconds before start"
sleep $WAIT_SECONDS

spawn-fcgi -d $MAIN_FILE_DIR -f $MAIN_FILE -a 127.0.0.1 -p $PORT

sudo ln -nfs $(pwd)/$LOCAL_SITE_CONF $NGINX_SITE_CONF
sudo nginx -s reload
