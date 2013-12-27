#!/usr/bin/env python
# -*- coding: utf-8 -*-

__version__ = "0.0.1"
__author__ = "Zhongwei Sun (zhongwei.sun2008@gmail.com)"

# ----------------------------------------
# Sending a metric via TCP
# http://docs.hostedgraphite.com/languageguide/lg_python.html
# ----------------------------------------

# build-in, 3rd party and my modules
import time
import socket

API_KEY = "2605acfa-d149-4f94-aae9-5095daa56a56"

if '__main__' == __name__:
    cur_users = 1
    while True:
        conn = socket.create_connection(("carbon.hostedgraphite.com", 2003))
        conn.send("%s.sunzhongwei_com.cur_users %s\n" % (API_KEY, cur_users))
        conn.close()
        cur_users += 1
        time.sleep(10)
        print "cur_users: %s, sleep 10 seconds" % cur_users

