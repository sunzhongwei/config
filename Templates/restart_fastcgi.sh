#!/bin/bash

# ----------------------------------------
# DESCRIPTION
#
# ----------------------------------------
set -x  # or use "set -o xtrace" to print the statement before you execute it.

MAIN_FILE_DIR="/data/apps/sunzhongwei/current"
MAIN_FILE="$MAIN_FILE_DIR/main.py"
kill -9 `pgrep -f "python $MAIN_FILE"`

PIDS=$(pgrep -f "python $MAIN_FILE")    # $() is preferred over backticks
if [[ -n $PIDS ]]; then    	        # this checks whether a variable is non-empty
  kill -9 $PIDS
  while [[ -n $PIDS ]]; do
    echo "sleep 1 seconds"
    sleep 1
    PIDS=$(pgrep -f "python $MAIN_FILE")
  done
fi

spawn-fcgi -d $MAIN_FILE_DIR -f $MAIN_FILE -a 127.0.0.1 -p 99999

while [ "$?" -ne "0" ]; do
  # in case exist code 255: "spawn-fcgi: bind failed: Address already in use", but process was aleady killed.
  echo "fail to start, retry in 1 second ..."
  sleep 1
  spawn-fcgi -d $MAIN_FILE_DIR -f $MAIN_FILE -a 127.0.0.1 -p 99999
done

echo "success starting"
