#!/bin/bash

# refer  spf13-vim bootstrap.sh`
CURRENT_DIR=`pwd`
FOR_VIM=true

echo "Step1: backing up current vim config"
today=`date +%Y%m%d`
if $FOR_VIM; then
    for i in $HOME/.vim $HOME/.vimrc $HOME/.vimrc.ctags $HOME/.vimrc.bundles $HOME/.tmux.conf; do [ -e $i ] && [ ! -L $i ] && mv $i $i.$today; done
    for i in $HOME/.vim $HOME/.vimrc $HOME/.vimrc.ctags $HOME/.vimrc.bundles $HOME/.tmux.conf; do [ -L $i ] && unlink $i ; done
fi

echo "Step2: setting up symlinks"
if $FOR_VIM; then
    ln -s $CURRENT_DIR/vimrc $HOME/.vimrc
    ln -s $CURRENT_DIR/vimrc.bundles $HOME/.vimrc.bundles
    ln -s "$CURRENT_DIR/vim" "$HOME/.vim"
    ln -s $CURRENT_DIR/vimrc.ctags $HOME/.vimrc.ctags
    ln -s $CURRENT_DIR/tmux.conf $HOME/.tmux.conf
fi

echo "Step3: update/install plugins using Vim-plug"
system_shell=$SHELL
export SHELL="/bin/sh"
if $FOR_VIM; then
    vim -u $HOME/.vimrc.bundles +PlugInstall! +PlugClean! +qall
fi
export SHELL=$system_shell

echo "Install Done!"
