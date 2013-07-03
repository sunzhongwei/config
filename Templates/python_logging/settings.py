#!/usr/bin/env python
# -*- coding: utf-8 -*-


import sys
import logging
import logging.handlers


# ----------------------------------------
# logging
# ----------------------------------------
# create parent logger
app_logger = logging.getLogger("app")
app_logger.setLevel(logging.DEBUG)

# formatter
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

# create rotating file handler
channel = logging.handlers.RotatingFileHandler(
        filename="app.log",
        maxBytes=10 * 1024 * 1024,
        backupCount=5)
channel.setLevel(logging.DEBUG)
channel.setFormatter(formatter)
app_logger.addHandler(channel)

# create console handler
channel = logging.StreamHandler(sys.stdout)
channel.setLevel(logging.DEBUG)
channel.setFormatter(formatter)
app_logger.addHandler(channel)


app_logger.info("haha")
