# Auto attach to or start a session
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/tmux/tmux.plugin.zsh

export TMUX_AUTO_ATTACH=true

function preexec_tmux() {
    if [[ -z "$TMUX" ]]; then
        return 0
    fi
    CURRENT_CMD=$(echo -n "$CURRENT_CMD" | sd '\s+$' '')
    if [[ $CURRENT_CMD = ${~HISTORY_IGNORE} ]]; then
        return 0
    fi
    cmd="$(echo $CURRENT_CMD | sd -f m '^\s*(\S+)\s*.*' '$1')"
    if [[ -z "$cmd" ]]; then
        return 0
    fi
    tmux rename-window -t${TMUX_PANE} "$cmd"
}
add-zsh-hook preexec preexec_tmux

if [[ -z "$TMUX" && $TMUX_AUTO_ATTACH = true ]]; then
    tmux attach || tmux new
fi
