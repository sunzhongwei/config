#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ----------------------------------------
# DESCRIPTION
# ===========
#
# ----------------------------------------

# build-in, 3rd party and my modules
import tornado.ioloop
import tornado.web


class MainHandler(tornado.web.RequestHandler):
    def get(self):
        self.write("Hello, world")


class TagHandler(tornado.web.RequestHandler):
    def get(self, tag, index):
        self.write("tag: %s, index: %s" % (tag, index))


class TagHomeHandler(tornado.web.RequestHandler):
    def get(self, tag):
        self.write("tag: %s" % tag)


application = tornado.web.Application([
    (r"/", MainHandler),
    (r"/tag/(.*)/(.*)", TagHandler),
    (r"/tag/(.*)", TagHomeHandler),
])


if __name__ == "__main__":
    application.listen(8889)
    tornado.ioloop.IOLoop.instance().start()

