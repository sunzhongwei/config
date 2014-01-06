#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ----------------------------------------
# DESCRIPTION
# ===========
# tornado version: 3.0.1
# curl http://localhost:8899; echo
# * 使用 golang 的并发 sleep 测试 tornado gen 在其他函数中返回的可行性
# ----------------------------------------

# build-in, 3rd party and my modules
import tornado
import tornado.ioloop
import tornado.web


class MainHandler(tornado.web.RequestHandler):
    '''curl "http://localhost:8888/abc?a=b&c=d"

    path: /abc, query: a=b&c=d
    '''
    def get(self):
        path = self.request.path
        query = self.request.query
        print "path: %s, query: %s" % (path, query)
        self.write("hello")


application = tornado.web.Application([
    (r"/.*", MainHandler),
], debug=True)


if __name__ == "__main__":
    application.listen(8888)
    tornado.ioloop.IOLoop.instance().start()

