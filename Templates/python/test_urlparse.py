#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ----------------------------------------
# Just say "Hello world!".
# ----------------------------------------


from urlparse import urlparse, urljoin

if '__main__' == __name__:
    url = "http://www.sunzhongwei.com/forum-187-1.html"
    o = urlparse(url)
    print o

    print urljoin("http://sunzhongwei.com/", "/index.html")
