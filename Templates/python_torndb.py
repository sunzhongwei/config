#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ----------------------------------------
# DESCRIPTION
# ===========
#
# ----------------------------------------

# build-in, 3rd party and my modules
import time
import torndb
import traceback


# ----------------------------------------
# test cases
# ----------------------------------------
def run_doctest():
    '''python -B <__file__> -v
    '''
    import doctest
    doctest.testmod()


db = torndb.Connection("localhost", "dmp_weixin", "dmp_weixin", "password")

def run():
    for report in db.query("SELECT * FROM detail_report LIMIT 5"):
        print report.id


if '__main__' == __name__:
    while True:
        try:
            print db._db
            run()
        except Exception, e:
            print e
            print traceback.format_exc()
        finally:
            time.sleep(5)

