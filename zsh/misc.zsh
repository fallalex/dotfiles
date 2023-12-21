
# case "$OSTYPE" in
#     darwin*)
#         sudo launchctl limit maxfiles 50000 200000
#     ;;
#     # linux*)
#     # ;;
#     # dragonfly*|freebsd*|netbsd*|openbsd*)
#     # ;;
# esac

eval "$(zoxide init --cmd j zsh)"

# https://github.com/jenv/jenv/issues/148
eval "$(pyenv init --no-rehash -)"
eval "$(pyenv virtualenv-init -)"
eval "$(rbenv init --no-rehash -)"
eval "$(jenv init --no-rehash -)"

(pyenv rehash & rbenv rehash & jenv rehash &) 2> /dev/null

# SSH agent
# https://gist.github.com/vancluever/de1c3985c8f9e2a3c4bdc42a057e075e
SSH_AUTH_SOCK="$HOME/.ssh/ssh-agent.sock"
SSH_AGENT_CMD="ssh-agent -a $SSH_AUTH_SOCK"
SSH_AGENT_PID=$(pgrep -U $UID -f "$SSH_AGENT_CMD")
if [[ ! -n "$SSH_AGENT_PID" || ! -S "$SSH_AUTH_SOCK" ]]; then
    pkill -U $UID ssh-agent
    rm -f $SSH_AUTH_SOCK
    eval $SSH_AGENT_CMD &> /dev/null
fi
export SSH_AGENT_PID
export SSH_AUTH_SOCK

# GPG agent - load key into cache if needed
# https://demu.red/blog/2016/06/how-to-check-if-your-gpg-key-is-in-cache/
#$(gpg-connect-agent 'keyinfo --list' /bye | rg -F " 1 " -c >/dev/null) || pass otp.yaml 2>&1 > /dev/null
