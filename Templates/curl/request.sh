#!/bin/bash

# ----------------------------------------
# DESCRIPTION
#
# ----------------------------------------
set -e	# or use "set -o errexit" to quit on error.
set -x  # or use "set -o xtrace" to print the statement before you execute it.

curl -d '' -b 'foo=bar' -w "@curl_format.txt" -s http://www.baidu.com
