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
import json
import time
import os.path
from sqlalchemy import Column, Integer, String, DateTime
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, scoped_session
from sqlalchemy.ext.declarative import declarative_base

from wsgilog import WsgiLog


# ----------------------------------------
# settings
# ----------------------------------------
LOG_FILE = "/tmp/webpy.log"     # use full path
LOG_FORMAT = '%(asctime)s %(levelname)s %(message)s'
LOG_BACKUPS = 10

sqlite_db_path = "/tmp/webpy.sqlite"
engine = create_engine("sqlite:///%s" % sqlite_db_path, echo=True)
Model = declarative_base()


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

def loadhook(handler):
    '''http://webpy.org/cookbook/sqlalchemy
    '''
    web.ctx.orm = scoped_session(sessionmaker(bind=engine))
    start_time = time.time()
    try:
        ret = handler()
    except web.HTTPError:
        web.ctx.orm.commit()
        ret = BaseServerError.json_response()
    except:
        web.ctx.orm.rollback()
        ret = BaseServerError.json_response()
    finally:
        end_time = time.time()
        web.ctx.orm.commit()

        # If the above alone doesn't work, uncomment
        # the following line:
        #web.ctx.orm.expunge_all()
    print "url: %s; cost_time: %0.3fs; response: %s" % (web.ctx.path,
            end_time-start_time, ret)
    return ret

urls = (
    "/todos", "TodosHandler",
    "/todos/(\d+)", "TodoHandler",
    '/(.*)', 'HelloHandler',
)
app = web.application(urls, globals())
app.add_processor(loadhook)


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
class HelloHandler:
    def GET(self, name):
        if not name:
            name = 'World'
        return 'Hello, ' + name + '!'

class TodosHandler:
    def GET(self):
        todos = web.ctx.orm.query(Todo).all()
        result = {"data": []}
        for todo in todos:
            result["data"].append({"id": todo.id, "content": todo.content})
        return json.dumps(result)

    def POST(self):
        data = web.input()
        todo = Todo(content=data.content)
        web.ctx.orm.add(todo)
        return json.dumps({})

class TodoHandler:
    def GET(self, todo_id):
        todo = web.ctx.orm.query(Todo).filter_by(id=todo_id).one()
        return json.dumps({"data": {"id": todo.id, "content": todo.content}})

    def PUT(self, todo_id):
        data = web.input()
        todo = web.ctx.orm.query(Todo).filter_by(id=todo_id).one()
        todo.content = data.content
        return json.dumps({})

    def DELETE(self, todo_id):
        web.ctx.orm.query(Todo).filter_by(id=todo_id).delete()
        return json.dumps({})


# ----------------------------------------
# errors
# ----------------------------------------
class BaseError(Exception):
    ret = 0
    errcode = 0
    msg = "ok"

    @classmethod
    def json_response(cls):
        response = {"ret": cls.ret, "errcode": cls.errcode,
                "msg": cls.msg}
        return json.dumps(response)

class Success(BaseError):
    pass

class BaseParamError(BaseError):
    ret = 1
    msg = "invalid parameters"

class BaseAuthError(BaseError):
    ret = 3
    msg = "auth error"

class BaseServerError(BaseError):
    ret = 4
    msg = "server error"

class NotExistError(BaseParamError):
    errcode = 1
    msg = "not exist"


if __name__ == "__main__":
    web.wsgi.runwsgi = lambda func, addr=None: web.wsgi.runfcgi(func, addr)
    create_tables()
    app.run(Log)


