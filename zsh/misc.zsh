# Way to profile zsh
# https://htr3n.github.io/2018/07/faster-zsh/
# and use this command /usr/bin/time zsh -i -c exit
# zmodload zsh/zprof

case "$OSTYPE" in
    darwin*)
        sudo launchctl limit maxfiles 50000 200000
    ;;
    # linux*)
    # ;;
    # dragonfly*|freebsd*|netbsd*|openbsd*)
    # ;;
esac


# https://github.com/jenv/jenv/issues/148
eval "$(rbenv init --no-rehash -)"
(rbenv rehash &) 2> /dev/null

eval "$(jenv init --no-rehash -)"
(jenv rehash &) 2> /dev/null

