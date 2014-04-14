#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ----------------------------------------
# DESCRIPTION
# ===========
#
# ----------------------------------------

# build-in, 3rd party and my modules
import time
import traceback


def retry(f):
    delay = 5

    def deco_retry(*args, **kw):
        while True:
            try:
                result = f(*args, **kw)
                break
            except:
                print traceback.format_exc()
                print "Exception happens, retry in %s seconds." % delay
                time.sleep(delay)
        return result

    return deco_retry


def time_it(method):

    def timed(*args, **kw):
        start_time = time.time()
        result = method(*args, **kw)
        end_time = time.time()
        print '%r (%r, %r) %2.2f sec' % \
              (method.__name__, args, kw, end_time-start_time)
        return result

    return timed


@retry
def say_hi():
    print "hi"
    raise Exception("haha")


@retry
def say_hi2():
    print "hi2"


@time_it
def eating():
    time.sleep(3)


# ----------------------------------------
# test cases
# ----------------------------------------
def run_doctest():
    '''python -B <__file__> -v
    '''
    import doctest
    doctest.testmod()


if '__main__' == __name__:
    eating()
    say_hi2()
    say_hi()

