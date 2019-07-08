source ~/.zplug/init.zsh
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"
# zplug load --verbose
zplug load > /dev/null

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Prompt
autoload -Uz promptinit
RPROMPT=
promptinit
prompt pure > /dev/null

#precmd_tasks() {
#    RPROMPT='%f%F{red}$(task +capture +PENDING count)%f'
#    if [[ $(task +capture +PENDING count) = 0 ]]; then
#        RPROMPT=""
#    fi
#}
#add-zsh-hook precmd precmd_tasks

# Completion Settings
zstyle ':completion:*' completer _complete _ignored _correct _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' rehash true
zstyle ':completion::complete:*' gain-privileges 1
# zstyle :compinstall filename '/home/fallalex/.zshrc'

setopt COMPLETE_ALIASES autocd beep extendedglob nomatch
autoload -Uz compinit
compinit

# History Settings
HISTFILE=~/.history
HISTSIZE=3000                           # internal history
SAVEHIST=$HISTSIZE                      # history file
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_LEX_WORDS
setopt HIST_VERIFY
setopt EXTENDED_HISTORY
setopt HIST_FCNTL_LOCK

# Set default vi mode to Normal
function zle-line-init { zle -K vicmd }
zle -N zle-line-init
KEYTIMEOUT=1

# NeoVim
EDITOR=/usr/local/bin/nvim
VISUAL=$EDITOR
PAGER="$EDITOR -R"
MANPAGER="$EDITOR -u NORC -c 'set ft=man' -"
bindkey -v
bindkey -M vicmd v edit-command-line
autoload edit-command-line; zle -N edit-command-line
MYVIMRC="$HOME/.config/nvim/init.vim"
VIMINIT=$MYVIMRC
alias vim=nvim
alias vi=nvim
alias ibmproxy='ssh -qND localhost:8088 ibmvpn'
alias ibmproxy='ssh -qND localhost:8088 ibmvpn'

# updates the prompt every 15 seconds
TMOUT=15
TRAPALRM() { zle reset-prompt }
