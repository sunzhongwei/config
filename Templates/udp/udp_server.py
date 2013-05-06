#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ----------------------------------------
# DESCRIPTION
# ===========
#
# ----------------------------------------

# build-in, 3rd party and my modules
import socket


server = socket.socket( socket.AF_INET, socket.SOCK_DGRAM ) # 使用数据报文
server.bind(('', 17800)) # 绑定服务端口

print 'udpserver start'

while True:
    data, (addr, port) = server.recvfrom( 1024 )
    print data, addr, port

