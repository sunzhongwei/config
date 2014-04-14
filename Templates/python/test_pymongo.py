#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ----------------------------------------
# DESCRIPTION
# ===========
#
# ----------------------------------------

# build-in, 3rd party and my modules
import time
import pymongo
#from pymongo.errors import AutoReconnect    # pre version
from pymongo.errors import ConnectionFailure    # 2.5.2


MONGODB_HOST = "localhost"
MONGODB_PORT = 27017
MONGODB_DATABASE_NAME = "test_db"


# ----------------------------------------
# MongoDB
# ----------------------------------------
while True:
    try:
        # http://emptysqua.re/blog/pymongos-new-default-safe-writes/
        # By default, Connection did unacknowledged writes—it didn't call
        # getLastError at all. You could change that with the safe option
        # like:
        mongodb_connection = pymongo.Connection(MONGODB_HOST, MONGODB_PORT,
                safe=True)
        break
    except ConnectionFailure, err:
        print "Could not connect to MongoDB: %s" % err
        print "Retry in 5 seconds"
        time.sleep(5)
db = mongodb_connection[MONGODB_DATABASE_NAME]


def create_index():
    db.task.ensure_index([("name", 1), ])


def test():
    collection = db["task"]


    collection.insert({"name": "zhongwei"})

    print "count function"
    print collection.find({"name": "zhongwei"}).count()

    result = collection.find({"name": "zhongwei"})
    print result
    print "result count"
    print result.count()

    #print len(result)
    items = [item for item in result]
    print items
    print len(items)

    items = collection.find()
    for item in items:
        # get unexist field
        print item.get("heihei", None)


def test_upsert():
    '''The $inc operator increments a value of a field by a specified amount.
    If the field does not exist, $inc sets the field to the specified amount.
    $inc accepts positive and negative incremental amounts.

    upsert = True, perform insert if not exist, else update.
    '''
    db.task.update({"date": "2013-07-22"}, {"$inc": {"count": 10}},
                   upsert=True)
    for item in db.task.find({"date": "2013-07-22"}):
        print item


def test_find_one():
    item = db.task.find_one({"heihei": "heiehie"})
    print item

# ----------------------------------------
# test cases
# ----------------------------------------
def run_doctest():
    '''python -B <__file__> -v
    '''
    import doctest
    doctest.testmod()


if '__main__' == __name__:
    test_find_one()

