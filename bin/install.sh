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
python-dev
tmux
git
nginx
spawn-fcgi
python-flup
python-pip
PACKAGES


# python modules
cat <<PYTHON_PACKAGES | xargs pip install
pyflakes==0.5.0
mercurial==2.1.2
ipython==0.12
SQLAlchemy==0.8.0b2
fabric==1.4.1
PYTHON_PACKAGES


