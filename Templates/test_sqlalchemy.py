#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ----------------------------------------
# DESCRIPTION
# ===========
# test sqlalchemy
# ----------------------------------------

# build-in, 3rd party and my modules
import os.path
from sqlalchemy import Column, Integer, String, DateTime, ForeignKey
from sqlalchemy import Boolean
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
#from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base
import datetime


cur_file_path = os.path.realpath(__file__)
cur_dir_path = os.path.dirname(cur_file_path)
sqlite_db_path = os.path.join(cur_dir_path, "test.sqlite")
engine = create_engine("sqlite:///%s" % sqlite_db_path, echo=True)
Model = declarative_base()
Session = sessionmaker(bind=engine)
session = Session()     # create a Session


class Person(Model):
    __tablename__ = "person"

    id = Column(Integer(unsigned=True), primary_key=True,
            autoincrement=True)
    name = Column(String(255), nullable=False)
    is_man = Column(Boolean, nullable=False)
    created_at = Column(DateTime)
    updated_at = Column(DateTime)

    #books = relationship("book")


class Book(Model):
    __tablename__ = "book"

    id = Column(Integer(unsigned=True), primary_key=True,
            autoincrement=True)
    name = Column(String(255), nullable=False)
    owner = Column(Integer(unsigned=True), ForeignKey("person.id"),
            nullable=False)


def create_tables():
    Model.metadata.create_all(engine)


def insert_data():
    now = datetime.datetime.now()
    person = Person(name="zhongwei", is_man=True,
            created_at=now, updated_at=now)
    session.add(person)
    session.commit()


def query_data():
    person = session.query(Person).filter_by(name="zhongwei").order_by(
            Person.created_at).first()
    print person.name, person.created_at


# ----------------------------------------
# test cases
# ----------------------------------------
def run_doctest():
    '''python -B <__file__> -v
    '''
    import doctest
    doctest.testmod()


if '__main__' == __name__:
    create_tables()
    insert_data()
    query_data()


