export EDITOR=$(which nvim)
export PAGER="/usr/local/bin/less"
export MANPAGER="$EDITOR +Man!"
export MANWIDTH=999
MYVIMRC="$HOME/.config/nvim/init.vim"
VIMINIT=$MYVIMRC

alias v="$EDITOR"
alias vim="$EDITOR"
alias vimr="$EDITOR --noplugin -R -c 'syn off'"

