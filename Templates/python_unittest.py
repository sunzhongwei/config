#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ----------------------------------------
# DESCRIPTION
# ===========
#
# ----------------------------------------

# build-in, 3rd party and my modules
import unittest


class TestHelloWorld(unittest.TestCase):
    def setUp(self):
        self.name = "zhongwei"

    def tearDown(self):
        self.name = None

    def test_hello_world(self):
        expected_value = "zhongwei"
        self.assertEqual(self.name, expected_value)

    def test_for_fail(self):
        expected_value = "qq"
        self.assertEqual(self.name, expected_value)


if '__main__' == __name__:
    unittest.main()


