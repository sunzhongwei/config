#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ----------------------------------------
# Just say "Hello world!".
# ----------------------------------------
import time
import datetime
from redis.sentinel import Sentinel

SENTINEL_NODES = (
    ('localhost', 26379),
    ('localhost', 26380),
    ('localhost', 26381),
)

sentinel = Sentinel(SENTINEL_NODES, socket_timeout=0.1)
master = sentinel.master_for('master', socket_timeout=0.1, password="123456")



if '__main__' == __name__:
    while True:
        now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        try:
            master.set('cur_time', now)
            print "%s Write successfully!" % now
        except Exception, e:
            print e
            print "%s Write failed!" % now
        time.sleep(1)

