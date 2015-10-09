#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
  echo "this is a Mac OS"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  echo "this is a Linux"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
  echo "this is a Windows"
fi
