#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ----------------------------------------
# DESCRIPTION
# ===========
# 测试 redis 重启是否会影响连接, 测试方案：
# 1. connection pool in application level
# 2. one connection in application level
#
# python module:
# * redis: 2.8.0
# * hiredis: 0.1.1
# ----------------------------------------

# build-in, 3rd party and my modules
import datetime
import redis
import tornado
import tornado.ioloop
import tornado.web


class BaseHandler(tornado.web.RequestHandler):
    @property
    def redis_conn(self):
        return redis.Redis(connection_pool=self.application.redis_pool)


class HomeHandler(BaseHandler):
    def get(self):
        '''shut down redis server.
        self.redis_conn.set("name", "zhongwei") will raise exception.

        File "/usr/local/lib/python2.7/dist-packages/redis/connection.py", line 235, in connect
            raise ConnectionError(self._error_message(e))
        ConnectionError: Error 111 connecting localhost:6379. Connection refused.

        after restart redis server, all work well.
        '''
        self.redis_conn.set("name", "zhongwei")
        name = self.redis_conn.get("name")
        now = datetime.datetime.now()
        self.write("%s, %s" % (name, now))


class Application(tornado.web.Application):
    def __init__(self):
        handlers = [
            (r".*", HomeHandler),
        ]

        settings = dict(
            debug=True,
        )

        tornado.web.Application.__init__(self, handlers, **settings)

        # TODO: max connection
        self.redis_pool = redis.ConnectionPool(host='localhost',
                                               port=6379, db=0)


if __name__ == "__main__":
    app = Application()
    app.listen(8889)
    tornado.ioloop.IOLoop.instance().start()

