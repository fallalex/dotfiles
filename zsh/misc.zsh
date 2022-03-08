
# case "$OSTYPE" in
#     darwin*)
#         sudo launchctl limit maxfiles 50000 200000
#     ;;
#     # linux*)
#     # ;;
#     # dragonfly*|freebsd*|netbsd*|openbsd*)
#     # ;;
# esac

eval "$(zoxide init zsh)"

# https://github.com/jenv/jenv/issues/148
eval "$(pyenv init --path)"
eval "$(pyenv init --no-rehash -)"
eval "$(pyenv virtualenv-init -)"
eval "$(rbenv init --no-rehash -)"
eval "$(jenv init --no-rehash -)"
(pyenv rehash & rbenv rehash & jenv rehash &) 2> /dev/null

# SSH agent
SSH_AUTH_SOCK=$HOME/.ssh/ssh-agent.sock
SSH_AGENT_PID=$(pgrep -U $UID ssh-agent)
if [[ ! -n "$SSH_AGENT_PID" ]]; then
    rm -f $SSH_AUTH_SOCK
    eval `ssh-agent -a $SSH_AUTH_SOCK` > /dev/null
else
    export SSH_AGENT_PID
    export SSH_AUTH_SOCK
fi

# GPG agent - load key into cache if needed
# https://demu.red/blog/2016/06/how-to-check-if-your-gpg-key-is-in-cache/
$(gpg-connect-agent 'keyinfo --list' /bye | rg -F " 1 " -c >/dev/null) || pass otp.yaml 2>&1 > /dev/null
