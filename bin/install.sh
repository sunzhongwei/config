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


APTITUDE_OPTIONS="-y"
apt-get update
cat <<PACKAGES | xargs apt-get install $APTITUDE_OPTIONS
gcc
make
libevent-dev
libncurses5-dev
tmux
git
nginx
spawn-fcgi
python-flup
python-pip
PACKAGES


