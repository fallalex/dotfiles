PATH="/usr/local/sbin:$PATH"
PATH="$HOME/scripts/.scripts:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.jenv/bin:$PATH"
export PATH

FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
FPATH=$HOME/scripts/.scripts:$FPATH
export FPATH
