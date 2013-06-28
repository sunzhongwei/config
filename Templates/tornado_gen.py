#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ----------------------------------------
# DESCRIPTION
# ===========
# tornado version: 3.0.1
# curl http://localhost:8899; echo
# ----------------------------------------

# build-in, 3rd party and my modules
import datetime
import tornado
import tornado.ioloop
import tornado.web
from tornado import gen
from tornado.httpclient import AsyncHTTPClient, HTTPRequest


class MainHandler(tornado.web.RequestHandler):
    '''must use @tornado.web.asynchronous
    '''
    @tornado.web.asynchronous
    @gen.coroutine
    def get(self):
        try:
            self.finish(str(datetime.datetime.now()))
        finally:
            http_client = AsyncHTTPClient(max_clients=20)
            headers = {"User-Agent": "testing tornado gen"}
            url = "http://www.python.org"
            req = HTTPRequest(url, request_timeout=3, headers=headers)
            rsp = yield http_client.fetch(req)
            print rsp.body[:100]
            print datetime.datetime.now()


application = tornado.web.Application([
    (r"/", MainHandler),
], debug=True)


if __name__ == "__main__":
    application.listen(8899)
    tornado.ioloop.IOLoop.instance().start()

