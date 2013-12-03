#!/usr/bin/env python
# -*- coding: utf-8 -*-

__version__ = "0.0.1"
__author__ = "Zhongwei Sun (zhongwei.sun2008@gmail.com)"

# ----------------------------------------
# Just say "Hello world!".
# ----------------------------------------

# build-in, 3rd party and my modules
import decimal


def test_decimal(num):
    d = decimal.Decimal(num * 100)
    chopped = d.quantize(decimal.Decimal(".01"), decimal.ROUND_DOWN)
    print "%s%%" % (chopped, )


def test_float(num):
    print "%0.2f%%" % (num * 100, )


if '__main__' == __name__:
    num = 0.999999999
    test_decimal(num)
    test_float(num)

