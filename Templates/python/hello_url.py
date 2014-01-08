#!/usr/bin/env python
# -*- coding: utf-8 -*-

__version__ = "0.0.1"
__author__ = "Zhongwei Sun (zhongwei.sun2008@gmail.com)"

# ----------------------------------------
# Just say "Hello world!".
# ----------------------------------------

# build-in, 3rd party and my modules
from urlparse import urlparse, parse_qs
from urllib import quote_plus, quote


def test():
    '''scheme://netloc/path;parameters?query#fragment
    '''
    url = 'http://localhost/?fi=/details/www.sunzhongwei.com'
    url = urlparse(url)
    path = url.path
    query = url.query
    print "path: %s, query: %s" % (path, query)
    print parse_qs(query)


def test_url_encode():
    '''http://www.w3schools.com/tags/ref_urlencode.asp
    由于 url 只支持 ascii 编码，所以需要转换。
    '''
    url = "next=/#/details/www.test.com"
    print "origin url is: %s" % url

    print "urllib.quote result:\n%s" % quote(url)
    print "urllib.quote_plus (which will quote slash) result:\n%s" % quote_plus(url)


if '__main__' == __name__:
    test()
    test_url_encode()

