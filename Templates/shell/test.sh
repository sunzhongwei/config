#!/bin/bash

# ----------------------------------------
# DESCRIPTION
#
# ----------------------------------------
# set -e	# or use "set -o errexit" to quit on error.
set -x

echo "Use 'test condition' or '[ condition ]' to create bool result."
echo "对文件、字符串、数字做判断，均可使用 test"
echo "相等时，返回 0; 不等时，返回 1"

# ----------------------------------------
# 单条件判断
# ----------------------------------------
# 注意：[] 两侧均需要添加空格
[ -f test.sh ]
echo $?

test -f test.sh
echo $?

# 为了此处正常运行下去，需要注释掉
# 	set -e
[ -f not_exist.sh ]
echo $?

test -f not_exist.sh
echo $?

# ----------------------------------------
# 多条件判断
# ----------------------------------------
# and
[ -f test.sh -a -f not_exist.sh ]
echo $?

[ -f test.sh -a -e test.sh ]
echo $?

# or
[ -f test.sh -o -f not_exist.sh ]
echo $?

# not
[ ! -f test.sh ]
echo $?

[ ! -f not_exist.sh ]
echo $?

# ----------------------------------------
# 测试字符串
# ----------------------------------------
STR_1="zhongwei sun"
STR_2="xiaoyan"
# Notes:
# == 等同于 =，但是 == 更具可读性
# 字符串变量建议用双引号括起来, 防止字符串中带空格等, 造成
# too many arguments
[ "$STR_1" == "$STR_2" ]
echo $?

[ "$STR_1" != "$STR_2" ]
echo $?

# 是否是空串
[ -z "$STR_1" ]
echo $?

# 是否是非空串
[ -n "$STR_1" ]
echo $?

# ----------------------------------------
# 数字
# ----------------------------------------
INT_1=100
INT_2=99
[ 100 -eq 99 ]
echo $?

[ 100 -eq 100 ]
echo $?

[ $INT_1 -eq $INT_2 ]
echo $?

[ $INT_1 -eq $INT_1 ]
echo $?

