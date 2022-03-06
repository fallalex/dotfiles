HISTFILE=$XDG_STATE_HOME/zsh-history
HISTSIZE=5000                           # internal history
SAVEHIST=9223372036854775807            # history file - set to max value possible in zsh

setopt HIST_NO_FUNCTIONS
setopt HIST_FIND_NO_DUPS
setopt NO_SHARE_HISTORY
setopt HIST_LEX_WORDS
setopt HIST_VERIFY
setopt EXTENDED_HISTORY
setopt HIST_FCNTL_LOCK
setopt INTERACTIVECOMMENTS

function precmd_history() {
    local -i rc=$?
    emulate -L zsh
    setopt extendedglob
    # Only enter command in history with return 0 and not ignored
    if (( $rc == 0 && $+_HISTLINE && $#_HISTLINE )); then
        # builtin print -rs -- $_HISTLINE
        unset _HISTLINE
        # incremental append history
        fc -AI
    fi
}
add-zsh-hook precmd precmd_history

function zshaddhistory() {
    emulate -L zsh
    setopt extendedglob
    # trim trailing whitespace for comparison
    _HISTLINE=$(echo -n "$1" | sd '\s+$' '')
    if [[ $_HISTLINE = ${~HISTORY_IGNORE} ]]; then
        unset _HISTLINE
        return 1
    # dont add '-' to history could not find another way
    # this does not clear them from the history file
    elif [[ "$_HISTLINE" = "-" ]]; then
        unset _HISTLINE
        return 1
    fi
    # we never want to succeed here as we manually set
    # history in precmd if this returns double entry occurs
    # return 1
    return 0
}

