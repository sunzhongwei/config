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
from sqlalchemy import Boolean, and_, Table
from sqlalchemy import create_engine, func
from sqlalchemy.orm import sessionmaker
from sqlalchemy.orm import relationship
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
    name = Column(String(255), nullable=False, index=True)
    is_man = Column(Boolean, nullable=False)
    score = Column(Integer(unsigned=True))
    created_at = Column(DateTime)
    updated_at = Column(DateTime)

    #books = relationship("book")
    def __repr__(self):
        return "<Person('%s', '%s', '%s', '%s', '%s')>" % (
                self.name, self.is_man, self.score, self.created_at,
                self.updated_at)


class Book(Model):
    __tablename__ = "book"

    id = Column(Integer(unsigned=True), primary_key=True, autoincrement=True)
    name = Column(String(255), nullable=False)
    owner = Column(Integer(unsigned=True), ForeignKey("person.id"),
            nullable=False)


# ----------------------------------------
# test many to many
# ----------------------------------------
sentence_tag = Table("sentence_tag", Model.metadata,
    Column("sentence_id", Integer(unsigned=True), ForeignKey("sentence.id")),
    Column("tag_id", Integer(unsigned=True), ForeignKey("tag.id"))
)


class Sentence(Model):
    __tablename__ = "sentence"

    id = Column(Integer(unsigned=True), primary_key=True, autoincrement=True)
    content = Column(String(500), nullable=False)
    tags = relationship("Tag", secondary=sentence_tag, backref="sentences")

    def _find_or_create_tag(self, tag_name):
        query = session.query(Tag).filter_by(name=tag_name)
        tag = query.first()
        if not tag:
            tag = Tag(name=tag_name)
        return tag

    def _get_tags(self):
        return [tag.name for tag in self.tags]

    def _set_tags(self, tag_names):
        # clear the list first
        while self.tags:
            del self.tags[0]
        # add new tag
        for tag_name in tag_names:
            self.tags.append(self._find_or_create_tag(tag_name))

    str_tags = property(_get_tags, _set_tags)

    def __repr__(self):
        return "id: %s, content: %s, tags: %s" % (self.id, self.content,
                self.str_tags)


class Tag(Model):
    __tablename__ = "tag"

    id = Column(Integer(unsigned=True), primary_key=True, autoincrement=True)
    name = Column(String(50), nullable=False, unique=True)


def create_tables():
    Model.metadata.create_all(engine)


def insert_data():
    now = datetime.datetime.now()
    person = Person(name="zhongwei", is_man=True,
            created_at=now, score=100, updated_at=now)
    session.add(person)
    session.commit()

    person = Person(name="zhongwei", is_man=True,
            created_at=now, score=200, updated_at=now)
    session.add(person)
    session.commit()

    person = Person(name="qq", is_man=True,
            created_at=now, score=200, updated_at=now)
    session.add(person)
    session.commit()


def query_data():
    person = session.query(Person).filter_by(name="zhongwei").order_by(
            Person.created_at).first()
    print person.name, person.created_at


def query_average():
    print "test query_average"
    avg = session.query(func.avg(Person.score))\
            .filter_by(name="zhongwei").first()[0]
    if avg is None:
        print "No result found!"
    else:
        print "avg is: %s" % (avg)


def query_average_by_group():
    print "test query_average_by_group"
    avg_by_name = session.query(Person.name, func.avg(Person.score))\
            .group_by(Person.name).all()
    print avg_by_name

    avg_by_name = session.query(Person.name, func.avg(Person.score))\
            .filter_by(is_man=False).group_by(Person.name).all()
    print avg_by_name

    avg_by_name = session.query(Person.name, func.sum(Person.score), func.count(Person.score))\
            .group_by(Person.name).all()
    print avg_by_name


def query_with_filter():
    print "test query_with_filter"
    persons = session.query(Person).filter(and_(Person.name=="zhongwei",
        Person.is_man==True)).all()
    for person in persons:
        print person

    persons = session.query(Person).filter(and_(Person.name=="zhongwei",
        Person.is_man==False)).all()
    for person in persons:
        print person


def test_many_to_many():
    sentence = Sentence(content="Hello world!")
    session.add(sentence)
    session.commit()

    sentence.str_tags = ["test", "test2"]
    session.commit()
    print sentence


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
    #insert_data()
    #query_data()
    #query_average_by_group()
    #query_with_filter()
    test_many_to_many()


