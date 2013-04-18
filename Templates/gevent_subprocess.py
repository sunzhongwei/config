#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ----------------------------------------
# DESCRIPTION
# ===========
# test gevent subprocess
#
# 注意：
# gevent.subprocess 是 gevent version 1.0 加入的新功能，需要更新 gevent
# 参考 https://github.com/surfly/gevent
#
# 安装方法
# pip install cython -e git://github.com/surfly/gevent.git@1.0rc2#egg=gevent
# ----------------------------------------

# build-in, 3rd party and my modules
from gevent.pool import Pool
from gevent.subprocess import Popen, PIPE


POOL_SIZE = 10
pool = Pool(POOL_SIZE)


def worker():
    sub = Popen(['sleep 1; uname'], stdout=PIPE, shell=True)
    out, err = sub.communicate()
    return out.rstrip()


def run():
    greetlets = []
    for i in xrange(20):
        greetlets.append(pool.spawn(worker))

    pool.join()
    results = [greetlet.value for greetlet in greetlets]
    print results


if '__main__' == __name__:
    '''耗时 2.0609869957
    '''
    import time
    start_at = time.time()
    run()
    print time.time() - start_at

