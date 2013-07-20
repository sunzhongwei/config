#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ----------------------------------------
# DESCRIPTION
# ===========
#
# ----------------------------------------

# build-in, 3rd party and my modules
import os.path
from sqlalchemy import Column, Integer, String
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base


sqlite_db_path = "/data/data/test/db.sqlite"
db_dir = os.path.split(sqlite_db_path)[0]
if not os.path.exists(db_dir):
    os.makedirs(db_dir)
engine = create_engine("sqlite:///%s" % sqlite_db_path)
Model = declarative_base()


class User(Model):
    __tablename__ = "user"

    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(255), nullable=False, index=True, unique=True)
    msg = Column(String(1000))

    def __repr__(self):
        return "<user(%s, %s, %s)>" % (self.id, self.name, self.msg)


def create_tables():
    Model.metadata.create_all(engine)


create_tables()

