#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ----------------------------------------
# DESCRIPTION
# ===========
#
# ----------------------------------------

# build-in, 3rd party and my modules


def test():
    l = [
        {"name": "zhongwei", "ago": 88},
        {"name": "haha", "ago": 12},
        {"name": "guagua", "ago": 25},
    ]
    l.sort(key=lambda x: x["ago"])
    print l


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

