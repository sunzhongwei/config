#!/usr/bin/env python
# -*- coding: utf-8 -*-

__version__ = "0.0.1"
__author__ = "Zhongwei Sun (zhongwei.sun2008@gmail.com)"

# ----------------------------------------
# Just say "Hello world!".
# ----------------------------------------

# build-in, 3rd party and my modules
from tornado.template import Loader


def render_html():
    loader = Loader("./")
    print loader.load("email_lite.html").generate(name="zhongwei")


if '__main__' == __name__:
    render_html()

