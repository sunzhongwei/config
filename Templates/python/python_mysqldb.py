#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ----------------------------------------
# DESCRIPTION
# ===========
#
# ----------------------------------------

# build-in, 3rd party and my modules
import time
import MySQLdb


conn = None


def init_conn():
    global conn
    while True:
        try:
            conn = MySQLdb.connect(
                    host="localhost", db="test",
                    user="test", passwd="password",
                    charset="utf8")
            break
        except MySQLdb.Error, e:
            print str(e)
            time.sleep(5)

init_conn()


def retry(func):
    def call(*args, **kwargs):
        while True:
            try:
                return func(*args, **kwargs)
            except MySQLdb.Error, e:
                if 'MySQL server has gone away' in str(e):
                    print "retry in 5 seconds"
                    time.sleep(5)
                    init_conn()
                else:
                    raise e

    return call


@retry
def get_data():
    '''(2006, 'MySQL server has gone away')
    '''
    cursor = conn.cursor()
    cursor.execute('''
        SELECT `id` FROM test
        WHERE id = %s;
    ''', (55, ))

    result = cursor.fetchone()
    cursor.close()

    try:
        status = result[0]
    except:
        return None

    return status


if '__main__' == __name__:
    while True:
        print get_data()
        time.sleep(5)

