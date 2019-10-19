#!/bin/sh

mv zsh ~/.zsh
mv tmux ~/.tmux
mv vim ~/.vim

ln -s ~/.zshrc ~/.zsh/zshrc
ln -s ~/.tmux.conf ~/.tmux/tmux.conf
ln -s ~/.vimrc ~/.vim/vimrc

git submodule update --init --recursive
