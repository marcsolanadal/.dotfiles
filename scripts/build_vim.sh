#! /bin/bash

# Downlading vim sources into temporal folder
cd /tmp
git clone https://github.com/vim/vim.git
cd vim

# Install necessary packages for lua and python support
sudo apt-get install -y liblua5.1-dev luajit libluajit-5.1 python-dev

# Remove all vim previous installations
sudo apt-get remove -y --purge vim vim-runtime vim-gnome vim-tiny vim-common vim-gui-common
sudo rm -rf /usr/bin/vim

# Configure lua paths
sudo mkdir /usr/include/lua5.1/include
sudo mv /usr/include/lua5.1/*.h /usr/include/lua5.1/include/
sudo ln -s /usr/bin/luajit-2.0.3 /usr/bin/luajit

make distclean

./configure --enable-luainterp \
  --enable-gui=no \
  --without-x \
  --enable-multibyte \
  --prefix=/usr \
  --with-lua-prefix=/usr/include/lua5.1 \
  --with-luajit \
  --enable-cscope \
  --enable-fail-if-missing \
  --enable-pythoninterp \
  --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu/

make
sudo make install

rm -rf /tmp/vim
