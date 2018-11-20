test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

PATH=$PATH:~/go/bin:~/scripts

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
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
zstyle ':completion::complete:*' gain-privileges 1
zstyle :compinstall filename '/home/fallalex/.zshrc'

setopt COMPLETE_ALIASES autocd beep extendedglob nomatch
autoload -Uz compinit
compinit

# History Settings
HISTFILE=~/.history
HISTSIZE=3000                           # internal history
SAVEHIST=$HISTSIZE                      # history file
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
setopt HIST_LEX_WORDS
setopt HIST_VERIFY
setopt EXTENDED_HISTORY
setopt HIST_FCNTL_LOCK

function precmd()  { echo; }
function preexec() { echo; }
RPS1="%(?.%F{green}.%F{red})%?%f"
PS2="%_  > "
# Update prompt when switching vi modes
function zle-keymap-select {
  VIMODE="${${KEYMAP/vicmd/CMD}/(main|viins)/INS}"
  PS1="%B%D{%R} %4~%b
${VIMODE} %B%#%b "
  zle reset-prompt
}
zle -N zle-keymap-select

# Set default vi mode to Command/Normal
function zle-line-init { zle -K vicmd }
zle -N zle-line-init

# vi
EDITOR=/usr/local/bin/nvim
VISUAL=$EDITOR
alias vim=nvim
alias vi=nvim
bindkey -v
KEYTIMEOUT=1                            # .1 seconds for reading vi mode switch

# updates the prompt every 15 seconds for clock
TMOUT=15
TRAPALRM() { zle reset-prompt }

# Syntax Highlighting
source $(glocate zsh-syntax-highlighting.zsh)

# enable 'help' command for zsh
autoload -Uz run-help
alias help=run-help

alias ll=gls -la --color=auto

