# this has helped me before with stuff like:
# (eval):1: \_mv: function definition file not found
glocate zcompdump | xargs rm -f

sudo launchctl limit maxfiles 50000 200000
ulimit 50000

source ~/.zplug/init.zsh
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"
zplug "rupa/z", use:z.sh
# zplug load --verbose
zplug load > /dev/null

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Setup color
# git@github.com:mbadolato/iTerm2-Color-Schemes.git
# solarized dark
export TERM=xterm-256color
# git clone git@github.com:seebi/dircolors-solarized.git
eval `gdircolors ~/dircolors-solarized/dircolors.ansi-dark`

# Prompt
autoload -Uz promptinit
RPROMPT=
promptinit
prompt pure > /dev/null

precmd_tasks() {
    RPROMPT=""
    TASKCOUNT=$(task +cap +PENDING count)
    # https://www.reddit.com/r/zsh/comments/cgbm24/multiline_prompt_the_missing_ingredient/
    if [[ ${TASKCOUNT} -ne 0 ]]; then
        RPROMPT='%f%F{red}${TASKCOUNT}%f'
    fi
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
zstyle ':completion:*' rehash true
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion::complete:*' gain-privileges 1
# zstyle ':completion:*' squeeze-slashes true
# zstyle ':completion:*' use-compctl false
# zstyle :compinstall filename '/home/fallalex/.zshrc'

eval "$(bw completion --shell zsh); compdef _bw bw;"
fpath=(/Users/afall/scripts/bw-scripts $fpath)

setopt COMPLETE_ALIASES MENU_COMPLETE autocd beep extendedglob nomatch
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

function clear-scrollback-buffer {
  clear && printf '\e[3J'
  zle && zle .reset-prompt && zle -R
}

# NeoVim & ZSH vi mode
export EDITOR=/usr/local/bin/nvim
#export VISUAL=$EDITOR
export PAGER="$EDITOR -Rc AnsiEsc -c 'set number!' -c 'set relativenumber!'"
export MANPAGER="$EDITOR -u NORC -c 'set ft=man' -"
bindkey -v
bindkey '^[[Z' reverse-menu-complete
bindkey -M vicmd v edit-command-line
autoload edit-command-line; zle -N edit-command-line
bindkey '^L' clear-scrollback-buffer
autoload clear-scrollback-buffer; zle -N clear-scrollback-buffer
MYVIMRC="$HOME/.config/nvim/init.vim"
VIMINIT=$MYVIMRC
# brew install findutils
alias gupdatedb='gupdatedb --localpaths=$HOME --output=$HOME/tmp/locatedb --prunepaths=$HOME/Library'
alias glocate='glocate --database=$HOME/tmp/locatedb'
alias reload='exec zsh -l'
alias vim=nvim
alias vimr='vim --noplugin -R -c "syn off"'
alias ff='fzf'
alias viles="$PAGER"
alias dt='date "+%F %T"'
alias dat='date "+%Y%m%d"'
alias journal='vim ~/vimwiki/journal/`date "+%F"`.md'
alias c='clear-scrollback-buffer'
alias ~='cd ~'
alias ..='cd ../'
alias echopath='echo -e ${PATH//:/\\n}'
alias otpass='pass otp.yaml | otpass.py'
#alias led='ledger --init-file ~/ledger/ledgerrc -f ~/ledger/ledger'
#alias ecu=' sshpass -p `pass ibm | head -1` ssh ecurep'
#alias ibmproxy='autossh -M 0 -qND localhost:8088 ibmvpn'
alias dnsflush='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder'
alias ls='gls -h --time-style=long-iso --color=auto'
alias ll='ls -Fl'
alias lg='ll --group-directories-first'
alias lt='ll -tr --time-style=full-iso'
alias l.='ll -d .*'
alias files='find -f $(pwd)'
alias g='git'
alias jv='jenv'
alias jvg='jenv shell $(jenv global)'
alias jvl='jenv shell $(jenv local)'
alias jvpaths='ll $HOME/.jenv/versions'
alias jvpath='ll `jenv prefix`'
alias rv='rbenv'
alias rvg='rbenv shell $(rbenv global)'
alias rvl='rbenv shell $(rbenv local)'
alias tw='timew'
alias ex='exuno'
alias vr='vrops'
alias labvpn='sshuttle --dns -r relay 10.0.10.0/24'
alias bmftp='ftp ftp.bluemedora.com'
alias pyhist="cat ~/.ptpython/history | sed 's/^\+//' | sed 's/^\#.*//' | tr -s '\n'"
alias gitrepos='hub api --paginate /orgs/BlueMedora/repos | ~/scripts/git_scripts/github_repos_paginator.py'
alias listrepos='~/scripts/git_scripts/gitrepos.py'
alias otp='otpass'
alias wr='curl -s wttr.in | ghead -n -2'
alias rad='curl -s "https://radar.weather.gov/Conus/Loop/NatLoop.gif" > radar.gif; mpv --loop-file=inf --fs radar.gif'
alias tk='task'
alias deploylogs="log show --info --debug --last 30m --style compact --predicate 'subsystem == \"com.bluemedora.vrops-deploy.daemon\"'"
alias bw='bw --session `den -sn`'
# Find git repos
#glocate -r /.git$ | xargs gdirname

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
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/scripts/bw-scripts:$PATH"
source $HOME/scripts/link_scripts/link_scripts.sh

export VAULT_ADDR=https://vault.bluemedora.localnet:8200
export VAULT_GITHUB_TOKEN=`pass bm_hashi_vault`
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
eval "$(rbenv init -)"
