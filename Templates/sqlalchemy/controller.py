#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ----------------------------------------
# DESCRIPTION
# ===========
#
# ----------------------------------------

# build-in, 3rd party and my modules
from sqlalchemy.orm import sessionmaker
import models


Session = sessionmaker(bind=models.engine)
session = Session()     # create a Session


def save():
    user = models.User(name="zhongwei", msg="Hello world!")
    session.add(user)
    session.commit()


if '__main__' == __name__:
    save()

