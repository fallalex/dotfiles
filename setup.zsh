#!/usr/bin/env zsh

. zsh/variables.zsh

function link() {
    abs_path=$(realpath $1)
    mkdir -p $(dirname $2)
    ln -vsf $abs_path $2
}

mkdir -p $XDG_CONFIG_HOME
mkdir -p $XDG_CACHE_HOME
mkdir -p $XDG_DATA_HOME
mkdir -p $XDG_STATE_HOME

link zsh/zshenv ~/.zshenv
link zsh/zshrc $XDG_CONFIG_HOME/zsh/.zshrc
link python/python-startup.py $XDG_CONFIG_HOME/python/python-startup.py
link python/ptpython-config.py $XDG_CONFIG_HOME/ptpython/config.py
touch $XDG_CONFIG_HOME/ptpython/__init__.py
link tmux/tmux.conf $XDG_CONFIG_HOME/tmux/tmux.conf
link git/gitconfig $XDG_CONFIG_HOME/git/config
link vim/init.vim $XDG_CONFIG_HOME/nvim/init.vim
link alacritty.yml $XDG_CONFIG_HOME/alacritty/alacritty.yml
link starship.toml $XDG_CONFIG_HOME/starship.toml

mkdir -p $VIM_PLUG_VIM
curl -sL https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > $VIM_PLUG_VIM/plug.vim
# run :PlugInstall

tmp=$XDG_DATA_HOME/tmux/plugins/tpm 
mkdir -p $tmp
git clone https://github.com/tmux-plugins/tpm $tmp || git -C $tmp pull
# (prefix + I) to install plugins


# TODO: clone fzf and run ./install --bin
