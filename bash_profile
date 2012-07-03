# set global PATH on OS X
# =======================
# 有三种方法
# 1. 直接修改 /etc/paths
# 2. 在 /etc/paths.d 目录下添加对应程序需要添加的路径 
# 例如：go 语言的 /etc/paths.d/go
# 3. 在 ~/.bash_profile 中赋值
# 修改 paths 的方法只适用于 Mac OS. CentOS 上没有对应的文件。
# http://serverfault.com/questions/16355/how-to-set-global-path-on-os-x
#
# 使用 export 赋值与直接使用 = 赋值的区别
# =======================================
# 使用 export 赋值的变量能够被子进程继承，而直接使用 = 的不能。
# 但是在子进程中，无论使用 export 还是 = 都无法改变父进程的值。
# 而这里所说的父进程，通常是指 bash shell，所以通常修改环境变量都是通过
# source <some_script>.sh
#
# pretty-print json
# =================
# echo '<raw_json>' | python -mjson.tool
# example:
# echo '{"msg": "ok", "data": {"list": [{"website": "letv", "url": "http://www.letv.com/ptv/pplay/75420/2.html", "video_id": "1594024"}], "cover": "http://img0.hao123.com/data/1_410778331e67b59a079ce4f802fcb26d"}, "ret": 0}' | python -mjson.tool
# http://stackoverflow.com/questions/352098/how-to-pretty-print-json-script
#
# get return code of program
# ==========================
# $ echo $?

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export PATH=$PATH:$HOME/bin:/usr/local/sbin
export PATH=/usr/local/mysql/bin:$PATH
export SVN_EDITOR=vim
export EDITOR=vim

alias mysql_config='/usr/local/mysql/bin/mysql_config'
#export DYLD_LIBRARY_PATH=/usr/local/mysql/lib/:/usr/local/lib/

# remove text prefixing dollar sign
export PS1='\W \$ '

growl() { echo -e $'\e]9;'${1}'\007' ; return  ; }

##
# Your previous /Users/zhongwei/.bash_profile file was backed up as /Users/zhongwei/.bash_profile.macports-saved_2011-09-02_at_15:32:23
##

# MacPorts Installer addition on 2011-09-02_at_15:32:23: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

# crontab: temp file must be edited in place
alias crontab='EDITOR=/usr/bin/nano /usr/bin/crontab'

# startup virtualenv-burrito
if [ -f $HOME/.venvburrito/startup.sh ]; then
    . $HOME/.venvburrito/startup.sh
fi

# git auto-completion
source ~/.git-completion.bash
