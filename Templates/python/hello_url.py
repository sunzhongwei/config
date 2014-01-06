#!/usr/bin/env python
# -*- coding: utf-8 -*-

__version__ = "0.0.1"
__author__ = "Zhongwei Sun (zhongwei.sun2008@gmail.com)"

# ----------------------------------------
# Just say "Hello world!".
# ----------------------------------------

# build-in, 3rd party and my modules
from urlparse import urlparse, parse_qs


def test():
    '''scheme://netloc/path;parameters?query#fragment
    '''
    url = 'http://localhost/?fi=/details/www.sunzhongwei.com'
    url = urlparse(url)
    path = url.path
    query = url.query
    print "path: %s, query: %s" % (path, query)
    print parse_qs(query)


if '__main__' == __name__:
    test()

