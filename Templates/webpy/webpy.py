#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ----------------------------------------
# Run with port 5000
# $ python main.py 5000
#
# == requirements.txt ==
# flup
# web.py==0.37
# wsgilog==0.3
# fabric==1.4.1
#
# == notes ==
# make your file executable by doing chmod +x webpy.py. You'll get errors if
# it isn't executable.
# error message:
# "spawn-fcgi: child exited with: 126"
# ----------------------------------------

# build-in, 3rd party and my modules
import os
import web
import os.path
from sqlalchemy import Column, Integer, String, DateTime
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

from wsgilog import WsgiLog


# ----------------------------------------
# settings
# ----------------------------------------
LOG_FILE = "/tmp/webpy.log"
LOG_FORMAT = '%(asctime)s %(levelname)s %(message)s'
LOG_BACKUPS = 10

sqlite_db_path = "/tmp/webpy.sqlite"
engine = create_engine("sqlite:///%s" % sqlite_db_path, echo=True)
Model = declarative_base()

# create a configured "Session" class
Session = sessionmaker(bind=engine)

# create a Session
session = Session()


# ----------------------------------------
# initialize
# ----------------------------------------
log_dir = os.path.split(LOG_FILE)[0]
if not os.path.exists(log_dir):
    os.makedirs(log_dir)

class Log(WsgiLog):
    def __init__(self, application):
        WsgiLog.__init__(
            self,
            application,
            logformat = LOG_FORMAT,
            tofile = True,
            toprint = True,
            file = LOG_FILE,
            interval = "w0",
            backups = LOG_BACKUPS,
            datefmt = "%Y-%m-%d %H:%M:%S",
            )


urls = (
    '/(.*)', 'hello',
)
app = web.application(urls, globals())


# ----------------------------------------
# models
# ----------------------------------------
class Todo(Model):
    __tablename__ = "todo"

    id = Column(Integer(unsigned=True), primary_key=True,
            autoincrement=True)
    content = Column(String(255), nullable=False)
    created_at = Column(DateTime)

def create_tables():
    Model.metadata.create_all(engine)


# ----------------------------------------
# controller
# ----------------------------------------
class hello:
    def GET(self, name):
        if not name:
            name = 'World'
        return 'Hello, ' + name + '!'


if __name__ == "__main__":
    web.wsgi.runwsgi = lambda func, addr=None: web.wsgi.runfcgi(func, addr)
    create_tables()
    app.run(Log)


