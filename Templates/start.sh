#!/bin/bash

# ----------------------------------------
# DESCRIPTION
# Restart service.
# ----------------------------------------
set -x  # or use "set -o xtrace" to print the statement before you execute it.

MAIN_FILE_DIR="<some_dir>/src"
MAIN_FILE="$MAIN_FILE_DIR/main.py"
kill `pgrep -f "python $MAIN_FILE"`

WAIT_SECONDS=2
echo "sleep $WAIT_SECONDS seconds before start"
sleep $WAIT_SECONDS

spawn-fcgi -d $MAIN_FILE_DIR -f $MAIN_FILE -a 127.0.0.1 -p 8080

