# Auto attach to or start a session
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/tmux/tmux.plugin.zsh

function _zsh_tmux_cmd() {
    if [[ -n "$@" ]]; then
        command tmux "$@"
        return $?
    fi

    local -a tmux_cmd
    tmux_cmd=(command tmux)

    # Try to connect to an existing session.
   $tmux_cmd attach

    # If failed, just run tmux, fixing the TERM variable if requested.
    if [[ $? -ne 0 ]]; then
        $tmux_cmd new-session
    fi

    exit
}

compdef _tmux _zsh_tmux_cmd
alias tmux=_zsh_tmux_cmd

if [[ -z "$TMUX" ]]; then
    _zsh_tmux_cmd
fi
