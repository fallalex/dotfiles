# https://gist.github.com/Linerre/f11ad4a6a934dcf01ee8415c9457e7b2
# The following avoids any reliance on /usr/libexec/path_helper
export PATH=""
typeset -U PATH
path+=("$HOME/bin")
path+=("$HOME/.cargo/bin")
path+=("/usr/local/sbin")
path+=("/usr/local/bin")
path+=("/usr/bin")
path+=("/bin")
path+=("/usr/sbin")
path+=("/sbin")
path+=("$FZF_ROOT/bin")
path+=("$XDG_DATA_HOME/pyenv/shims")

while IFS=$'\n' read -r line; do
    path+=($line)
done <<< $(/usr/local/bin/fd -t f --base-directory /etc/paths.d -x /bin/cat)

export PATH

export MANPATH=""
typeset -U MANPATH

while IFS=$'\n' read -r line; do
    manpath+=($line)
done <<< $(/bin/cat /etc/manpaths)

while IFS=$'\n' read -r line; do
    manpath+=($line)
done <<< $(/usr/local/bin/fd -t f --base-directory /etc/manpaths.d -x /bin/cat)
export MANPATH


FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
FPATH=$HOME/bin/completion:$FPATH
export FPATH
