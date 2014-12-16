#!/bin/bash

# ----------------------------------------
# DESCRIPTION
#
# ----------------------------------------
set -x  # or use "set -o xtrace" to print the statement before you execute it.

echo "if 判断的是命令的返回结果。0 为真，1 为假。"
echo "[] 是 test 命令的简写. 所以，相等时返回的也是 0"

# 缩进非强制，但是可以增强可读性
if ls > /dev/null; then
    echo "true"
else
    echo "false"
fi

NAME="zhongwei"
if [ "$NAME" == "douban" ] ; then
    echo "douban"
elif [ "$NAME" == "zhongwei" ] ; then
    echo "zhongwei"
else
    echo "other"
fi

