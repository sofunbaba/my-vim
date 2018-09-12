#!/bin/bash

# refer  spf13-vim bootstrap.sh`
CURRENT_DIR=`pwd`
FOR_VIM=true

echo "Step1: setting up symlinks"
if $FOR_VIM; then
    ln -f -s $CURRENT_DIR/vimrc $HOME/.vimrc
    ln -f -s $CURRENT_DIR/vimrc.bundles $HOME/.vimrc.bundles
    ln -f -s "$CURRENT_DIR/vim" "$HOME/.vim"
    ln -f -s $CURRENT_DIR/vimrc.ctags $HOME/.vimrc.ctags
    ln -f -s $CURRENT_DIR/tmux.conf $HOME/.tmux.conf
fi

echo "Step2: update/install plugins using Vim-plug"
system_shell=$SHELL
export SHELL="/bin/sh"
if $FOR_VIM; then
    vim -u $HOME/.vimrc.bundles +PlugInstall! +PlugClean! +qall
fi
export SHELL=$system_shell

echo "Install Done!"
