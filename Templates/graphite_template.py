#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ----------------------------------------
# 功能描述
# * 监控 sf.xxx 每天扫描域名的情况
# ----------------------------------------

# build-in, 3rd party and my modules
import time
from socket import socket


CARBON_SERVER = ''
CARBON_PORT = 2003
graphite_delay = 1 * 60     # graphite 录入数据的最大时间间隔为 1 分钟，
                            # 否则无法连成线


def main():
    sock = socket()

    while True:
        try:
            sock.connect((CARBON_SERVER,CARBON_PORT))
            break
        except:
            print "Couldn't connect to %(server)s on port %(port)d, "\
                  "is carbon-agent.py running?" % {
                          'server': CARBON_SERVER,
                          'port': CARBON_PORT}
            print "Retry in 10 seconds"
            time.sleep(10)

    while True:
        try:
            dt = int(time.time())
            value = 1
            message = "app.zhongwei.daily_count %s %s\n" % ( value, dt)
            print "sending message\n"
            print '-' * 80
            print message
            print
            sock.sendall(message)
        except:
            pass
        time.sleep(graphite_delay)


if '__main__' == __name__:
    main()

