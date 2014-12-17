#!/bin/bash

# ----------------------------------------
# DESCRIPTION
#
# ----------------------------------------
set -e	# or use "set -o errexit" to quit on error.
set -x  # or use "set -o xtrace" to print the statement before you execute it.

echo day | sed s/day/night/

# 替换参数两侧加上引号是个好习惯，上面不加是因为里面没有 meta-characters
echo "day" | sed "s/day/night/"

# 将修改后的配置写入新文件
sed "s/debug\ =\ True/debug\ =\ False/" <old_sed.conf >new_sed.conf

# 默认只会修改每行的第一个匹配到的单词
sed "s/word/WORD/" <old_sed.conf >new_sed.conf

# 加上 g 替换掉所有
sed "s/test/TESTS/g" <old_sed.conf >new_sed.conf

# ----------------------------------------
# 分隔符
# ----------------------------------------
# s 后的第一个字符就是分隔符, 虽然大家常用的是 /, 但是在修改文件目录相关的
# 配置时，建议使用其他分隔符，例如 _ : |
# 直观上使用 | 更醒目，而且通常大家不会用 | 出现在文件名中
echo "hosts=/etc/hosts" | sed "s/\/etc\/hosts/\/etc\/hostsbak/"
echo "hosts=/etc/hosts" | sed "s_/etc/hosts_/etc/hostsbak_"
echo "hosts=/etc/hosts" | sed "s:/etc/hosts:/etc/hostsbak:"
echo "hosts=/etc/hosts" | sed "s|/etc/hosts|/etc/hostsbak|"

# ----------------------------------------
# 正则匹配
# ----------------------------------------
# -r --regexp-extented, Mac OS 中使用 -E
# & 代表匹配上的值
echo "loop_count = 30" | sed -r "s/[0-9]+/100/"
echo "loop_count = 30" | sed -r "s/[0-9]+/&*10/"

# ----------------------------------------
# 一个文件中需要多处 sed 操作
# ----------------------------------------
sed '
s/1/2/g
s/3/4/g
' <old_sed.conf >new_sed.conf
