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
    jobs.append(Job("http://kitcheneroktoberfest.com"))
    jobs.append(Job("http://kitchenfloortile.com"))
    jobs.append(Job("http://kitchentableset.com"))
    jobs.append(Job("http://kitepictures.com"))
    jobs.append(Job("http://boysboxers.com"))
    jobs.append(Job("http://freeadultsexchatroom.com"))
    jobs.append(Job("http://danceclubpictures.com"))
    jobs.append(Job("http://mileagedistance.com"))
    jobs.append(Job("http://militaryammunition.com"))
    jobs.append(Job("http://dancingbabyvideo.com"))
    jobs.append(Job("http://dancinggifs.com"))
    jobs.append(Job("http://krohnsdisease.com"))
    jobs.append(Job("http://kungfupictures.com"))
    jobs.append(Job("http://dartboardgame.com"))
    jobs.append(Job("http://ladiesformalwear.com"))
    jobs.append(Job("http://miniaturemotorcycles.com"))
    jobs.append(Job("http://ladieswallet.com"))
    jobs.append(Job("http://daycarepictures.com"))
    jobs.append(Job("http://daycarerates.com"))
    jobs.append(Job("http://lakehouseplan.com"))
    jobs.append(Job("http://daytonohiojobs.com"))
    jobs.append(Job("http://daytonohiomap.com"))
    jobs.append(Job("http://daytonohionews.com"))
    jobs.append(Job("http://minivanaccessory.com"))
    jobs.append(Job("http://lakemichiganmap.com"))
    jobs.append(Job("http://lakeoftheozarksmap.com"))
    jobs.append(Job("http://bridemaidsbouquets.com"))
    jobs.append(Job("http://forbes200.com"))
    jobs.append(Job("http://forbesmarket.com"))
    jobs.append(Job("http://miningmuseum.com"))
    jobs.append(Job("http://dratwood.com"))
    jobs.append(Job("http://drbrenda.com"))
    jobs.append(Job("http://drlloyd.com"))
    jobs.append(Job("http://mimiguarneri.com"))
    jobs.append(Job("http://promedon.com"))
    jobs.append(Job("http://frankstudios.com"))
    jobs.append(Job("http://residentialcontract.com"))
    jobs.append(Job("http://scentsofimagination.com"))
    jobs.append(Job("http://drlincoln.com"))
    jobs.append(Job("http://njjsfz.com"))
    jobs.append(Job("http://centralcarpet.com"))
    jobs.append(Job("http://statspin.com"))
    jobs.append(Job("http://wrightdigital.com"))
    jobs.append(Job("http://duggans-serra.com"))
    jobs.append(Job("http://strategics.com"))
    jobs.append(Job("http://simulogix.com"))
    jobs.append(Job("http://canada-stockwatch.com"))
    jobs.append(Job("http://zabel.com"))
    jobs.append(Job("http://tinytoys.com"))
    jobs.append(Job("http://holodyne.com"))
    jobs.append(Job("http://buckeyemachine.com"))
    jobs.append(Job("http://glendale-online.com"))
    jobs.append(Job("http://goldkeys.com"))
    jobs.append(Job("http://proptech.com"))
    jobs.append(Job("http://mediscribe.com"))
    jobs.append(Job("http://gallerym.com"))
    jobs.append(Job("http://musgroves.com"))
    jobs.append(Job("http://sinoexhibition.com"))
    jobs.append(Job("http://lowinsure.com"))
    jobs.append(Job("http://turkeynose.com"))
    jobs.append(Job("http://mittwede.com"))
    jobs.append(Job("http://adreslistesi.com"))
    jobs.append(Job("http://familyclipart.com"))
    jobs.append(Job("http://wipeoutcreditcarddebt.com"))
    jobs.append(Job("http://hitide.com"))
    jobs.append(Job("http://demko-ps.com"))
    jobs.append(Job("http://oeac.com"))
    jobs.append(Job("http://l9.com"))
    jobs.append(Job("http://rmhco.com"))
    jobs.append(Job("http://omsmedical.com"))
    jobs.append(Job("http://metropatio.com"))
    jobs.append(Job("http://summitry.com"))
    jobs.append(Job("http://westportyachts.com"))
    jobs.append(Job("http://viscount-gort.com"))
    jobs.append(Job("http://rivertown-inc.com"))
    jobs.append(Job("http://promedia-group.com"))
    jobs.append(Job("http://innovdata.com"))
    jobs.append(Job("http://dbmkt.com"))
    jobs.append(Job("http://mittleider.com"))
    jobs.append(Job("http://alloystainless.com"))
    jobs.append(Job("http://mr-bandwidth.com"))
    jobs.append(Job("http://cwwp.com"))
    jobs.append(Job("http://cestaticket.com"))
    jobs.append(Job("http://fsbokit.com"))
    jobs.append(Job("http://deliainc.com"))
    return jobs


class Job(object):
    def __init__(self, url, info=None):
        self.url = url
        self.info = info

    def __repr__(self):
        args = ",".join("%s=%r" % i for i in sorted(self.__dict__.items()))
        return "%s(%s)" % (self.__class__.__name__, args)


class TornadoWorker(object):
    def __init__(self, jobs, max_clients=10):
        self.max_clients = max_clients
        self.jobs = jobs
        self.total_jobs = len(jobs)
        self.finished_jobs_counter= 0
        self.headers = {
            "User-Agent": "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30)",
        }

    def _handle_request(self, url, start_time, response):
        print "url: %s, request_time: %s" % (url, response.request_time)
        if response.error:
            print "Error:", response.error
        else:
            print "OK: %s" % response.body[:2]

        self.finished_jobs_counter += 1
        print "url: %s, cost time: %0.3f" % (url, time.time() - start_time)

        if self.finished_jobs_counter == self.total_jobs:
            ioloop.IOLoop.instance().stop()

    def run(self):
        http_client = AsyncHTTPClient(max_clients=self.max_clients,
                defaults={"connect_timeout":3, "request_timeout":5})
        for job in self.jobs:
            req = HTTPRequest(job.url, connect_timeout=3, request_timeout=5,
                    headers=self.headers)
            start_time = time.time()
            http_client.fetch(req, functools.partial(self._handle_request,
                                                     job.url, start_time))

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
    print "total jobs: %s" % len(jobs)

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

