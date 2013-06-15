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
        mongodb_connection = pymongo.Connection(MONGODB_HOST, MONGODB_PORT)
        break
    except ConnectionFailure, err:
        print "Could not connect to MongoDB: %s" % err
        print "Retry in 5 seconds"
        time.sleep(5)
db = mongodb_connection[MONGODB_DATABASE_NAME]


def test():
    collection = db["task"]
    print collection.find({"name": "zhongwei"}).count()

    result = collection.find({"name": "zhongwei"})
    print result
    items = [item for item in result]
    print items


# ----------------------------------------
# test cases
# ----------------------------------------
def run_doctest():
    '''python -B <__file__> -v
    '''
    import doctest
    doctest.testmod()


if '__main__' == __name__:
    test()

