#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ----------------------------------------
# Run with port 5000
# $ python main.py 5000
# ----------------------------------------

# build-in, 3rd party and my modules
import web

urls = (
    '/(.*)', 'hello'
)
app = web.application(urls, globals())

class hello:
    def GET(self, name):
        if not name:
            name = 'World'
        return 'Hello, ' + name + '!'

if __name__ == "__main__":
    app.run()


