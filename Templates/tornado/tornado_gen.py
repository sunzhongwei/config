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
import time
import tornado
import tornado.ioloop
import tornado.web
from tornado import gen
from tornado.httpclient import AsyncHTTPClient, HTTPRequest


class MainHandler(tornado.web.RequestHandler):
    '''
    * must use @tornado.web.asynchronous before version 3.1
    '''
    @tornado.web.asynchronous
    @gen.coroutine
    def get(self):
        rsp = yield self._call_web_api()
        self.finish(rsp.body)

    def _call_web_api(self):
        http_client = AsyncHTTPClient(max_clients=20)
        headers = {"User-Agent": "testing tornado gen"}
        url = "http://localhost:8889"
        req = HTTPRequest(url, request_timeout=10, headers=headers)
        return http_client.fetch(req)


class BlockHandler(tornado.web.RequestHandler):
    def get(self):
        time.sleep(5)
        self.write("i sleep 5s")


application = tornado.web.Application([
    (r"/block", BlockHandler),
    (r"/", MainHandler),
], debug=True)


if __name__ == "__main__":
    application.listen(8888)
    tornado.ioloop.IOLoop.instance().start()

