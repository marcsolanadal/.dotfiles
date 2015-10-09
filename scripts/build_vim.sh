#! /bin/bash

PREP_COMPLETE=false

PREFIX="/opt/local"
LUA_PREFIX=""

# Downlading vim sources into temporal folder
cd /tmp
git clone https://github.com/vim/vim.git
cd vim

# Creating the installation folder in case it doesn't exists
if [ "$/opt/local/bin" ]; then
  echo "Creating the /opt/local/bin directory..."
  mkdir -p /opt/local/bin
fi

if [ "$(uname)" == "Darwin" ]; then
  echo "Mac OS detected..."
  echo "Installing required packages to build vim..."

  LUA_PREFIX="/usr/local/Cellar/lua51/5.1.2_2"

  brew install lua luajit python3 > /dev/null

  echo "Necessary packages installed..."

  PREP_COMPLETE=true

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  echo "Linux detected..."
  echo "Installing required packages to build vim..."

  LUA_PREFIX="/usr/include/lua5.1"

  # Install necessary packages for lua and python support
  sudo apt-get install -y liblua5.1-dev luajit libluajit-5.1 python-dev > /dev/null

  # Remove all vim previous installations
  sudo apt-get remove -y --purge vim vim-runtime vim-gnome vim-tiny vim-common vim-gui-common > /dev/null
  sudo rm -rf /usr/bin/vim

  # Configure lua paths
  sudo mkdir /usr/include/lua5.1/include
  sudo mv /usr/include/lua5.1/*.h /usr/include/lua5.1/include/
  sudo ln -s /usr/bin/luajit-2.0.3 /usr/bin/luajit

  echo "Necessary packages installed..."

  PREP_COMPLETE=true

elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
  echo "Windows detected..."
  echo "We don't have Windows support right now..."
  exit 0
fi

if [ "$PREP_COMPLETE" = true ]; then
  echo "Compiling Vim..."

  make distclean

  ./configure --enable-luainterp \
    --enable-gui=no \
    --without-x \
    --enable-multibyte \
    --prefix=$PREFIX \
    --with-lua-prefix=$LUA_PREFIX \
    --with-luajit \
    --enable-cscope \
    --enable-fail-if-missing \
    --enable-pythoninterp \
    --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu/

  make
  make install

fi

# Generating the corresponging symbolic links

rm -rf /tmp/vim


