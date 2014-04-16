#!/usr/bin/env python
# -*- coding: utf-8 -*-

__version__ = "0.0.1"
__author__ = "Zhongwei Sun (zhongwei.sun2008@gmail.com)"

# ----------------------------------------
# Just say "Hello world!".
# ----------------------------------------

# build-in, 3rd party and my modules
import time

def get_values():
    for i in xrange(10):
        time.sleep(1)
        if i==5:
            continue
        yield i


if '__main__' == __name__:
    for i in get_values():
        print i

