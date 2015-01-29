#!/bin/bash

# ----------------------------------------
# DESCRIPTION
#
# ----------------------------------------
set -e	# or use "set -o errexit" to quit on error.
set -x  # or use "set -o xtrace" to print the statement before you execute it.

# when in docker set root as USER
USER='dnsmasq'

if ! command -v dnsmasq > /dev/null; then
    yum install -y dnsmasq
else
    echo "dnsmasq was installed before, exit."
    exit 0
fi

if [ "$USER" != "root" ]; then
    groupadd -r $USER
    useradd -r -g $USER $USER
fi

cp /etc/dnsmasq.conf /etc/dnsmasq.conf.orig

# Arguments explain
#
# clear-on-reload
#     kill -HUP $dnsmasq_pid
#     make dnsmasq to clear cache
#
# listen-address
#     limit request machine
#
# resolv-file
#     like /etc/resolv.conf
#
# all-servers
#     send request to all DNS servers in $resolv-file, and use the fastest
#     response
#
# no-negcache
#     not cache negitive result
#
cat <<DNSMASQ_CONF > /etc/dnsmasq.conf
user=$USER
group=$USER
listen-address=127.0.0.1
resolv-file=/etc/dnsmasq.resolv.conf
all-servers
cache-size=1000
local-ttl=60
clear-on-reload
no-negcache
DNSMASQ_CONF

cat <<DNSMASQ_RESOLV_CONF > /etc/dnsmasq.resolv.conf
nameserver 114.114.114.114
nameserver 182.254.116.116
nameserver 119.29.29.29
DNSMASQ_RESOLV_CONF

# start dnsmasq service
/etc/init.d/dnsmasq start

# set service start on boot
chkconfig dnsmasq on

# confirm
if dig sunzhongwei.com @127.0.0.1 | grep 42.96.145.169 > /dev/null ; then
    echo "dnsmasq works! Nice!"
else
    echo "dnsmasq doesn't work! Please confirm!"
    exit 1
fi

# use dnsmasq as primary DNS server
cat <<RESOLV_CONF > /etc/resolv.conf
options timeout:1
options attempts:2
nameserver 127.0.0.1
nameserver 114.114.114.114
nameserver 182.254.116.116
nameserver 119.29.29.29
RESOLV_CONF

