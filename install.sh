#!/bin/bash

git config --global user.name "Marc Solà Nadal"
git config --global user.email "ionthasMail@gmail.com"

rm -rf ~/.emacs ~/.vim ~/.vimrc ~/.bashrc ~/.tmux.conf ~/.ssh

ln -s ~/.dotfiles/config/bashrc ~/.bashrc
ln -s ~/.dotfiles/config/vimrc ~/.vimrc
ln -s ~/.dotfiles/config/tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/config/emacs ~/.emacs
