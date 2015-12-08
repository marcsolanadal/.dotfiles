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

# Building vim from source with Python and Lua support.
# We need Python and Lua for the Ultisnips and Neocomplete plugins
./scripts/build_vim.sh

# Removing vim's previous configurations and creating symlinks
rm -rf ~/.vim ~/.vimrc
ln -s ~/.dotfiles/config/vimrc ~/.vimrc

# Setting up oh-my-zsh
rm -rf ~/.zshrc ~/.oh-my-zsh
ln -s ~/.dotfiles/config/zshrc ~/.zshrc
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -s ~/.dotfiles/config/zsh/ionthas.zsh-theme ~/.oh-my-zsh/themes/ionthas.zsh-theme

# Other programs
rm -rf ~/.emacs ~/.bashrc ~/.tmux.conf ~/.bash_profile ~/.irssi

ln -s ~/.dotfiles/config/bash_profile ~/.bash_profile
ln -s ~/.dotfiles/config/bashrc ~/.bashrc

ln -s ~/.dotfiles/config/tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/config/.irssi ~/.irssi
