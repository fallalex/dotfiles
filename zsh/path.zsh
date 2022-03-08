typeset -U PATH
path+=("$HOME/bin")
path+=("$HOME/.cargo/bin")
path+=("$FZF_ROOT/bin")
path+=("$XDG_DATA_HOME/pyenv/shims")
path+=("/usr/local/sbin")
export PATH

FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
FPATH=$HOME/bin/completion:$FPATH
export FPATH
