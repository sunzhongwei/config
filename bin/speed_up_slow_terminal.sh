#!/bin/bash

# ---------------------------------------- 
# 功能介绍:
# Speed up slow terminal on Mac OS X by deleting asl files (Apple System Log)
#
# 参考：
# http://superuser.com/questions/31403/how-can-i-speed-up-terminal-app-or-iterm-on-mac-osx 
# http://osxdaily.com/2010/05/06/speed-up-a-slow-terminal-by-clearing-log-files/
#
# tips：
# 1. 没有使用 
# cd /private/var/log/asl && sudo rm -rf * 
# 或者 rm *.asl
# 是为了防止进入了错误的目录，误删了文件。
# ---------------------------------------- 
sudo rm -rf /private/var/log/asl/*.asl

