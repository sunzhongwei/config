#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ----------------------------------------
# DESCRIPTION
# ===========
# urlgrabber version: 3.1.0
# 测试 python 的 http 长连接
# 通过测试发现，访问 python.org 20 次，使用长连接比不用长连接快一倍
# 参考：
# http://stackoverflow.com/questions/1037406/python-urllib2-with-keep-alive
# http://urlgrabber.baseurl.org/examples.html
# ----------------------------------------

# build-in, 3rd party and my modules
import urllib2
import time
from urlgrabber.keepalive import HTTPHandler
keepalive_handler = HTTPHandler()
opener = urllib2.build_opener(keepalive_handler)
urllib2.install_opener(opener)


def time_it(method):

    def timed(*args, **kw):
        start_time = time.time()
        result = method(*args, **kw)
        end_time = time.time()
        print '%r (%r, %r) %2.2f sec' % \
              (method.__name__, args, kw, end_time-start_time)
        return result

    return timed


#@time_it
#def test1():
#    for i in xrange(20):
#        print i
#        f = urlopen('http://www.baidu.com')
#        print f.read()[:10]


@time_it
def test2():
    for i in xrange(20):
        print i
        f = urllib2.urlopen('http://www.python.org')
        print f.read()[:10]


if '__main__' == __name__:
    test2()

