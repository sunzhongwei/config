#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ----------------------------------------
# DESCRIPTION
# ===========
# 为什么要使用异步的爬取方式
# * 不能保证每个网页都能短时间内返回
# * The GIL is not held by the Python interpreter when doing network operations.
#
# 参考：
# * # http://stackoverflow.com/questions/2830880/does-a-multithreaded-crawler-in-python-really-speed-things-up
# ----------------------------------------

# build-in, 3rd party and my modules
import time
import urllib2
import functools
from tornado import ioloop
from tornado.httpclient import AsyncHTTPClient, HTTPRequest


def get_jobs():
    jobs = []
    jobs.append(Job("http://www.twitter.com"))
    jobs.append(Job("http://www.sunzhongwei.com"))
    jobs.append(Job("http://www.baidu.com"))
    jobs.append(Job("http://www.goolge.com"))
    jobs.append(Job("http://www.python.org"))
    jobs.append(Job("http://www.douban.com"))
    return jobs


class Job(object):
    def __init__(self, url, info=None):
        self.url = url
        self.info = info

    def __repr__(self):
        args = ",".join("%s=%r" % i for i in sorted(self.__dict__.items()))
        return "%s(%s)" % (self.__class__.__name__, args)


class TornadoWorker(object):
    def __init__(self, jobs, max_clients=20):
        self.max_clients = max_clients
        self.jobs = jobs
        self.total_jobs = len(jobs)
        self.finished_jobs_counter= 0
        self.headers = {
            "User-Agent": "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30)",
        }

    def _handle_request(self, url, response):
        print url
        if response.error:
            print "Error:", response.error
        else:
            print "%s" % response.body[:20]

        self.finished_jobs_counter += 1

        if self.finished_jobs_counter == self.total_jobs:
            ioloop.IOLoop.instance().stop()

    def run(self):
        http_client = AsyncHTTPClient(max_clients=self.max_clients)
        for job in self.jobs:
            req = HTTPRequest(job.url, connect_timeout=5, request_timeout=3,
                              headers=self.headers)
            http_client.fetch(req, functools.partial(self._handle_request,
                                                     job.url))

        ioloop.IOLoop.instance().start()


class Urllib2Worker(object):
    def __init__(self, jobs):
        self.jobs = jobs

    def run(self):
        for job in self.jobs:
            content = urllib2.urlopen(job.url).read()
            print content[:20]


if '__main__' == __name__:
    print "start ..."
    jobs = get_jobs()

    start_time = time.time()
    tornado_worker = TornadoWorker(jobs)
    tornado_worker.run()
    end_time = time.time()
    cost_time = end_time - start_time
    print "cost time: %0.3fs" % cost_time

    t2 = time.time()
    urllib2_worker = Urllib2Worker(jobs)
    urllib2_worker.run()
    print "cost time: %0.3fs" % (time.time() - t2)

