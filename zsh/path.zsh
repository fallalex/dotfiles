# https://gist.github.com/Linerre/f11ad4a6a934dcf01ee8415c9457e7b2
# The following avoids any reliance on /usr/libexec/path_helper
export PATH=""
typeset -U PATH
path+=("$HOME/bin")
path+=("$DOTS_DIR/bin")
path+=("$HOME/.cargo/bin")
path+=("/usr/local/sbin")
path+=("/usr/local/bin")
path+=("/opt/homebrew/bin")
path+=("/usr/local/opt/coreutils/libexec/gnubin")
path+=("/usr/local/opt/findutils/libexec/gnubin")
path+=("/usr/local/opt/gnu-tar/libexec/gnubin")
path+=("/usr/bin")
path+=("/bin")
path+=("/usr/sbin")
path+=("/sbin")
path+=("$XDG_DATA_HOME/pyenv/shims")

while IFS=$'\n' read -r line; do
    path+=($line)
done <<< $(fd -t f --base-directory /etc/paths.d -x /bin/cat)

export PATH

export MANPATH=""
typeset -U MANPATH

while IFS=$'\n' read -r line; do
    manpath+=($line)
done <<< $(cat /etc/manpaths)

while IFS=$'\n' read -r line; do
    manpath+=($line)
done <<< $(fd -t f --base-directory /etc/manpaths.d -x /bin/cat)
export MANPATH

export FPATH=""
FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
FPATH=$(brew --prefix)/share/zsh/functions:$FPATH
FPATH=$HOME/bin/completion:$FPATH
export FPATH

eval "$(/opt/homebrew/bin/brew shellenv)"
