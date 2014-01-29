#!/bin/bash

# ----------------------------------------
# 功能介绍
# 将代码库中的配置文件复制到指定位置
# ----------------------------------------
OS=`uname`

cp vimrc ~/.vimrc
if [ "$OS" = "Linux" ]; then
    cp bashrc ~/.bashrc
else
    cp bash_profile ~/.bash_profile
fi;
cp tmux.conf ~/.tmux.conf
cp gitconfig ~/.gitconfig
cp gitignore_global ~/.gitignore_global

mkdir -p ~/.vim
cp -Rf vim/* ~/.vim/

mkdir -p ~/Templates
cp -Rf Templates/* ~/Templates/

mkdir -p ~/bin
cp -f bin/* ~/bin/

mkdir -p ~/.tmuxinator
cp -Rf tmuxinator/* ~/.tmuxinator/
