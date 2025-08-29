
alias o='openapp'
alias dnsflush='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder'
function spotlight { mdfind "kMDItemDisplayName == '$@'c"; }
alias apps='spotlight "*.app"'
function openapp() {
    apps | fzf --delimiter / --with-nth -1 | gxargs -i open {}
}

# Utilities
#alias led='ledger --init-file ~/ledger/ledgerrc -f ~/ledger/ledger'
# force this report to show dispite current context
alias otpass='pass otp.yaml | otpass.py'
alias otp='otpass'
alias journal="$EDITOR ~/vimwiki/journal/$(date '+%F').md"
alias wiki="$EDITOR -c VimwikiIndex"
alias mychive='cd $MYCHIVE'
alias labvpn='sshuttle --dns -r relay 10.0.10.0/24'
alias wr='curl -s wttr.in | ghead -n -2'
alias rad='curl -s "https://radar.weather.gov/Conus/Loop/NatLoop.gif" > radar.gif; mpv --loop-file=inf --fs radar.gif'
alias bw='bw --session `den -sn`'
alias rclone='rclone -P --password-command "den -pn rclone"'

# Shell
alias ppath='print -l $path'
alias px='whence -pm "*"'
alias pfpath='print -l $fpath'
alias pfpathl='print -l $fpath | gxargs -i fd --base-directory {} -a -t f -t l'
alias ss='rm -f $XDG_CONFIG_HOME/zsh/.zcompdump; exec zsh -l'
alias hr='fc -RI' # read hist from file
alias hl='fc -li -20' # local shell hist
alias hh='fc -li 0' # print all shell hist
alias ht="tail $HISTFILE"

# Essentials
alias dots='cd $DOTS_DIR'
alias -- -='cd -'
alias ~='cd ~'
alias ..='cd ../'
alias f='fd -uu'
alias ls='eza -ga -I ".git|.DS_Store" --git --time-style iso -s modified --group-directories-first'
alias la='eza --no-permissions --no-filesize --no-user --no-time -1da $PWD/.* $PWD/*'
compdef ls=eza
alias ll='ls -l'
alias tree='ls --tree'
alias mv='mv -iv'
alias cp='cp -iv'
alias ff='fzf'
alias dt='date "+%F %T"'
alias dat='date "+%Y%m%d"'
alias sshp='ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no'
alias ssh-cp-id-p='ssh-copy-id -o PreferredAuthentications=password -o PubkeyAuthentication=no'
alias u='aunpack'
alias info='info --vi-keys'
alias wget="wget --hsts-file /dev/null" # disable history
# TODO: make a function to handle .bak files
function swap() {
    local TMPFILE=tmp.$$
    /bin/mv "$1" $TMPFILE
    /bin/mv "$2" "$1"
    /bin/mv $TMPFILE "$2"
}
function mk() { mkdir -p "$1" && cd "$1"; }
alias cdr='cd -P .' #reload current directory

# Dev
alias g='git'
compdef g=git

alias rgd='ripgrep-delta'

alias gopen='open "$(git-https)"'
alias bare-repos='ssh git@git.labfall.com bare-repos'
function gclonecd() {
  git clone --recurse-submodules "$1" && cd "$(basename "$1" .git)"
}

alias c='cargo'
# rustup completions zsh cargo > ~/bin/completion/_cargo
compdef c=cargo

alias k='kubectl'
compdef k=kubectl

alias py='python'
alias pyhist="cat "$PTPYTHON_HISTORY" | sed 's/^\+//' | sed 's/^\#.*//' | tr -s '\n'"

# alias ppjson='python -m json.tool' # use 'jq .'
function todo() {
    fd -a todo | gxargs -i sh -c 'echo {}; bat -p {}'
    rg 'TODO[:\s]+' -C 5
}

alias gq='gojq'

function update-remote() {
    $DOTS_DIR/bin/update-remote $@
    cd -P .
}

function fzfcd() {
    if [ "$#" -ne 2 ] || [ ! -d "$2" ]; then
        echo Pass regex and base directory
        exit 1
    fi
    result=$(fd -d1 -td "$1" --base-directory "$2" | fzf -0 -1)
    fzfpath="$2/$result"
    if [ -n "$result" ] && [ $? -eq 0 ] && [ -d "$fzfpath" ]; then
        cd "$fzfpath"
    fi
}

alias ao='aoc-wrapper'
alias rp='rust-parallel'

# System
function interfaceips() { ifconfig -lu | tr -s ' ' \\n | /usr/bin/xargs -L1 ipconfig getifaddr; }
function localip() { ipconfig getifaddr $(route -n get default | awk '/interface:/ {print $2}'); }

alias ollamals='ollama list | sed "1d" | sort -V | hck -f1'
