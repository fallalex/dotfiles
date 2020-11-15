# Way to profile zsh
# https://htr3n.github.io/2018/07/faster-zsh/
# and use this command /usr/bin/time zsh -i -c exit
# zmodload zsh/zprof

# this has helped me before with stuff like:
# (eval):1: \_mv: function definition file not found
glocate zcompdump | xargs rm -f

sudo launchctl limit maxfiles 50000 200000
ulimit 50000

# https://github.com/jenv/jenv/issues/148
eval "$(rbenv init --no-rehash -)"
(rbenv rehash &) 2> /dev/null

eval "$(jenv init --no-rehash -)"
(jenv rehash &) 2> /dev/null

