#!/bin/bash

git clone https://github.com/vim-jp/vim.git ~/tmp/vim
cd ~/tmp/vim
./configure \
	--prefix=$HOME/local \
	--with-features=huge \
	--enable-multibyte \
	--enable-python3interp=yes \
	--enable-luainterp \
	--with-lua-prefix=$HOME/.anyenv/envs/luaenv/versions/5.2.1
