export TERM=xterm-256color

# Prompt
# autoload -Uz promptinit
RPROMPT=
# promptinit
# prompt pure > /dev/null

function preexec () {
    CURRENT_CMD=$1
}

function precmd_tasks() {
    RPROMPT=""
    # TASKCOUNT=$(task rc.verbose=nothing rc.context=none +cap +PENDING count) 
    # https://www.reddit.com/r/zsh/comments/cgbm24/multiline_prompt_the_missing_ingredient/
    # if [[ ${TASKCOUNT} -ne 0 ]]; then
    #     RPROMPT='%f%F{red}${TASKCOUNT}%f'
    # fi
}
add-zsh-hook precmd precmd_tasks

# https://github.com/sindresorhus/pure/issues/300
# this is to fix weird prompt collisions from completion
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# I ended up not liking this
# Set default vi mode to Normal
#function zle-line-init { zle -K vicmd }
function zle-line-init { }
zle -N zle-line-init
KEYTIMEOUT=1

# # This broke fzf and other completion menus
# # updates the prompt every 15 seconds
# TMOUT=15
# TRAPALRM() { zle reset-prompt }

# Completion Settings
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' format '--- Completing %d ---'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' rehash true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' squeeze-slashes true
zstyle :compinstall filename '/home/fallalex/.zshrc'

setopt menucomplete autocd extendedglob nomatch

autoload -Uz compinit
compinit

# actually clear the screen
function clear-scrollback-buffer {
  clear && printf '\e[3J'
  zle && zle .reset-prompt && zle -R
}

bindkey -v
bindkey '^[[Z' reverse-menu-complete
bindkey -M vicmd v edit-command-line
autoload edit-command-line; zle -N edit-command-line
bindkey '^L' clear-scrollback-buffer
autoload clear-scrollback-buffer; zle -N clear-scrollback-buffer

