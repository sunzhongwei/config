#!/bin/bash

# ----------------------------------------
# 功能介绍
# 将代码库中的配置文件复制到指定位置
# ----------------------------------------
cp vimrc ~/.vimrc
cp bash_profile ~/.bash_profile
cp tmux.conf ~/.tmux.conf
cp gitconfig ~/.gitconfig
cp gitignore_global ~/.gitignore_global

mkdir -p ~/.vim
cp -Rf vim/* ~/.vim/
mkdir -p ~/Templates
cp -f Templates/* ~/Templates/
mkdir -p ~/bin
cp -f bin/* ~/bin/

echo "if you are using Ubuntu, romove ~/.bash_profile"

