mkdir -p $HOME/golang
export GOPATH=$HOME/golang
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export PATH=$PATH:$HOME/bin:$GOPATH/bin:/usr/local/sbin
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

alias jslint="~/.npm/jslint/0.1.9/package/bin/jslint.js"


# ----------------------------------------
# auto completion for tmuxinator
# ----------------------------------------
_codeComplete()
{
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "$(ls ~/.tmuxinator/ | xargs basename -s .yml)" -- $cur) )
}

complete -F _codeComplete tmuxinator

