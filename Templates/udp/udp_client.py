#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ----------------------------------------
# DESCRIPTION
# ===========
#
# ----------------------------------------

# build-in, 3rd party and my modules
import socket


client = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
# 发送到本机端口17800
client.sendto("Hello Python", ('localhost', 17800))
client.close()

