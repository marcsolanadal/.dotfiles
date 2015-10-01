#!/bin/bash

# Setting up NTP
sudo apt-get install ntp ntpdate -y

# Local clock
sudo ln -sf /usr/share/zoneinfo/Europe/Andorra /etc/localtime
sudo hwclock --utc --systohc

# Setting up GIT
rm -rf ~/.gitconfig ~/.gitmessage
ln -s ~/.dotfiles/config/gitconfig ~/.gitconfig
ln -s ~/.dotfiles/config/gitmessage ~/.gitmessage

rm -rf ~/.emacs ~/.vim ~/.vimrc ~/.bashrc ~/.tmux.conf ~/.bash_profile ~/.irssi

ln -s ~/.dotfiles/config/bashrc ~/.bashrc
ln -s ~/.dotfiles/config/vimrc ~/.vimrc
ln -s ~/.dotfiles/config/tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/config/bash_profile ~/.bash_profile
ln -s ~/.dotfiles/config/.irssi ~/.irssi
