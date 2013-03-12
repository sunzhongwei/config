#!/bin/bash

# 使用方法
# 运行该脚本，即开启代理。Ctrl-c 中止该脚本，即关闭代理。
# 参考
# http://richardkmiller.com/925/script-to-enabledisable-socks-proxy-on-mac-os-x
# 针对 Mac OS X Lion 的修改
# One important update that you might want to mention is that in Mac OSX Lion,
# there is no service called ‘Airport’, and so this script will fail.
# Just replace ‘Airport’ with ‘Wi-Fi’ and it works like a champ.

#disable_proxy()
#{
#    networksetup -setsocksfirewallproxystate Wi-Fi off
#    networksetup -setsocksfirewallproxystate Ethernet off
#    echo "SOCKS proxy disabled."
#}
#trap disable_proxy INT
#
#networksetup -setsocksfirewallproxy Wi-Fi 127.0.0.1 7050
#networksetup -setsocksfirewallproxy Ethernet 127.0.0.1 7050
#networksetup -setsocksfirewallproxystate Wi-Fi on
#networksetup -setsocksfirewallproxystate Ethernet on
echo "SOCKS proxy enabled."
echo "Tunneling..."
ssh -ND 7050 root@106.187.48.157
