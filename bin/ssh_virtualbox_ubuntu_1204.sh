#!/bin/bash

# ---------------------------------------- 
# 功能介绍
# ssh 到 VirtualBox 中的 Ubuntu 12.04
#
# Tips:
# 默认情况下，VirtualBox 中安装的系统在启动后，IP 不在 192.168.1.X 段。
# 而是 10.0.2.X, 即，Mac OS 上无法 ping 通这个 IP。
# 这是由于虚拟机系统的默认网络连接方式是“网络地址转换（NAT）”。
# 这种网络连接方式只能保证正常的浏览网页，收取邮件，下载文件。但不能保证被
# 其他机器访问。
# 解决方法是，在 VirtualBox 的网络配置中，将连接方式更改为“桥接网卡”，
# 注意：需要针对有线或者 wifi 选择不同的参数，系统启动时，需要注意是否插了网线
# 重启系统，或者重启网络即可获得可用 IP。
# $ sudo /etc/init.d/networking restart
#
# Bridged networking. 详细介绍参考：
# http://www.virtualbox.org/manual/ch06.html
# http://stackoverflow.com/questions/5906441/how-to-ssh-to-a-virtualbox-ubuntu-guest-externally-through-a-windows-host
# 
# Network Address Translation (NAT)
# If all you want is to browse the Web, download files and view e-mail inside the guest, 
# then this default mode should be sufficient for you, and you can safely skip the rest 
# of this section. Please note that there are certain limitations when using Windows file 
# sharing (see the section called “NAT limitations” for details).
# 
# Bridged networking
# This is for more advanced networking needs such as network simulations and running servers 
# in a guest. When enabled, VirtualBox connects to one of your installed network cards and 
# exchanges network packets directly, circumventing your host operating system's network stack.
# ---------------------------------------- 

echo "Password: password"
ssh zhongwei@192.168.1.154


