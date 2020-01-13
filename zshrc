# this has helped me before with stuff like:
# (eval):1: \_mv: function definition file not found
locate zcompdump | xargs rm -f

# You can use this to "reload" a shell
# exec zsh -l

sudo launchctl limit maxfiles 50000 200000
ulimit 50000

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

precmd_tasks() {
    RPROMPT=""
    TASKCOUNT=$(task +cap +PENDING count)
    if [[ ${TASKCOUNT} -ne 0 ]]; then
        RPROMPT='%f%F{red}${TASKCOUNT}%f'
    fi
}
add-zsh-hook precmd precmd_tasks

# I ended up not liking this
# Set default vi mode to Normal
#function zle-line-init { zle -K vicmd }
function zle-line-init { }
zle -N zle-line-init
KEYTIMEOUT=1

# updates the prompt every 15 seconds
TMOUT=15
TRAPALRM() { zle reset-prompt }

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
setopt NO_SHARE_HISTORY
setopt HIST_LEX_WORDS
setopt HIST_VERIFY
setopt EXTENDED_HISTORY
setopt HIST_FCNTL_LOCK

# NeoVim & ZSH vi mode
export EDITOR=/usr/local/bin/nvim
#export VISUAL=$EDITOR
#export PAGER="$EDITOR -R"
#export MANPAGER="$EDITOR -u NORC -c 'set ft=man' -"
bindkey -v
bindkey -M vicmd v edit-command-line
autoload edit-command-line; zle -N edit-command-line
MYVIMRC="$HOME/.config/nvim/init.vim"
VIMINIT=$MYVIMRC
alias vimr='nvim -R'
alias vim=nvim
alias dt='date "+%F %T"'
alias c='clear'
alias ~="cd ~"
alias cd..='cd ../'
alias ..='cd ../'
alias echopath='echo -e ${PATH//:/\\n}'
alias ibmproxy='autossh -M 0 -qND localhost:8088 ibmvpn'
alias otpass='pass otp.yaml | otpass.py'
alias led='ledger --init-file ~/ledger/ledgerrc -f ~/ledger/ledger'
alias ecu=' sshpass -p `pass ibm | head -1` ssh ecurep'

# cd () {
#     if [ `echo $1 | grep -cE "^TS00[0-9]{7}$"` -eq 1 ]
#     then
#         builtin cd "/ecurep/sf/${1:0:5}/${1:5:3}/${1}"
#     else
#         builtin cd "$@"
#     fi
# }
#

export PATH="/usr/local/sbin:$PATH"
source $HOME/scripts/link_scripts/link_scripts.sh

export VAULT_ADDR=https://vault.bluemedora.localnet:8200
export VAULT_GITHUB_TOKEN=`pass bm_hashi_vault`
