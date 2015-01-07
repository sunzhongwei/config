#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ----------------------------------------
# DESCRIPTION
# ===========
# curl http://localhost:9999
# sudo service mysql start
# sudo service mysql stop
# ----------------------------------------

# build-in, 3rd party and my modules
#import time
import tornado
import tornado.ioloop
import tornado.web
import mytorndb as torndb
import datetime

db = torndb.Connection(
    host='localhost:3306',
    user='root',
    password='password',
    database='test',
    charset='utf8',
    read_timeout=2, write_timeout=2)

class MainHandler(tornado.web.RequestHandler):
    def get(self):
        #item = db.get('''
        #    SELECT user_id FROM likes
        #    WHERE likes_id = 1
        #''')
        print "start at: %s" % (datetime.datetime.now(), )
        try:
            r = db.get('''
                SELECT sleep(20)
            ''')
            print r
        except Exception, e:
            print e

        try:
            r = db.get('''
                SELECT 1
            ''')
            print r
        except Exception, e:
            print e
        print "end at: %s" % (datetime.datetime.now(), )
        self.finish("OK")

application = tornado.web.Application([
    (r"/", MainHandler),
], debug=True)

if __name__ == "__main__":
    application.listen(9999)
    tornado.ioloop.IOLoop.instance().start()

