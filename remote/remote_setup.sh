#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
scp $DIR/bash_profile $1:~/.bash_profile
scp $DIR/vimrc $1:~/.vimrc
scp $DIR/tmux.conf $1:~/.tmux.conf
