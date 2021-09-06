PATH="$HOME/bin:$PATH"
PATH="$HOME/scripts/.scripts:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.jenv/bin:$PATH"
PATH="$PYENV_ROOT/bin:$PATH"
PATH="/usr/local/sbin:$PATH"
export PATH
eval "$(pyenv init --path)"


FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
FPATH=$HOME/bin/completion:$FPATH
export FPATH
