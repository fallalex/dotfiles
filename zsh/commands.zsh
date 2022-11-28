
case "$OSTYPE" in
    darwin*)
        alias o='openapp'
        alias dnsflush='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder'
        function spotlight { mdfind "kMDItemDisplayName == '$@'wc"; }
        function openapp() {
            locate .app | rg -N ".*\.app$" | fzf | xargs -i open {}
        }
    ;;
    # linux*)
    # ;;
    # dragonfly*|freebsd*|netbsd*|openbsd*)
    # ;;
esac

# Utilities
#alias led='ledger --init-file ~/ledger/ledgerrc -f ~/ledger/ledger'
alias tw='timew'
alias t='task'
compdef t=task
alias tt="taskwarrior-tui"
# force this report to show dispite current context
alias caps='task rc.context=none rc.verbose=nothing capture'
alias cap='task rc.verbose=nothing cap --'
alias otpass='pass otp.yaml | otpass.py'
alias otp='otpass'
alias journal="$EDITOR ~/vimwiki/journal/$(date '+%F').md"
alias wiki="$EDITOR -c VimwikiIndex"
alias labvpn='sshuttle --dns -r relay 10.0.10.0/24'
alias wr='curl -s wttr.in | ghead -n -2'
alias rad='curl -s "https://radar.weather.gov/Conus/Loop/NatLoop.gif" > radar.gif; mpv --loop-file=inf --fs radar.gif'
alias bw='bw --session `den -sn`'
alias rclone='rclone -P --password-command "den -pn rclone"'

# Shell
alias ppath='print -l $path'
alias px='whence -pm "*"'
alias pfpath='print -l $fpath'
alias pfpathl='print -l $fpath | xargs -i fd --base-directory {} -a -t f -t l'
alias ss='rm -f $XDG_CONFIG_HOME/zsh/.zcompdump; exec zsh -l'
alias hr='fc -RI' # read hist from file
alias hl='fc -li -20' # local shell hist
alias hh='fc -li 0' # print all shell hist
alias ht="tail $HISTFILE"

# Essentials
alias -- -='cd -'
alias ~='cd ~'
alias ..='cd ../'
alias f='fd -uu'
alias ls='exa -ga -I ".git|.DS_Store" --git --time-style iso -s modified --group-directories-first'
alias la='exa --no-permissions --no-filesize --no-user --no-time -1da $PWD/.* $PWD/*'
compdef ls=exa
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
alias cat=bat
compdef cat=bat
alias wget="wget --hsts-file /dev/null" # disable history
# TODO: make a function to handle .bak files
function swap() {
    local TMPFILE=tmp.$$
    /bin/mv "$1" $TMPFILE
    /bin/mv "$2" "$1"
    /bin/mv $TMPFILE "$2"
}
function mk() { mkdir -p "$1" && cd "$1"; }
function trim() { awk '{$1=$1};1' }
alias cdr='cd -P .' #reload current directory

# Dev
alias g='git'
compdef g=git

function gclonecd() {
  git clone --recurse-submodules "$1" && cd "$(basename "$1" .git)"
}

alias py='python'
alias pv='pyenv'
alias pvg='pyenv shell $(pyenv global)'
alias pvl='pyenv shell $(pyenv local)'
alias pyhist="cat "$PTPYTHON_HISTORY" | sed 's/^\+//' | sed 's/^\#.*//' | tr -s '\n'"

alias jv='jenv'
alias jvg='jenv shell $(jenv global)'
alias jvl='jenv shell $(jenv local)'

function jvv() {
    echo "Shell: $(jenv shell 2>/dev/null)"
    echo "Local: $(jenv local 2>/dev/null)"
    echo "Global: $(jenv global)"
    exa --no-permissions --no-filesize --no-user --no-time -ld $(dirname $(jenv prefix))/*
}

alias jhomes='/usr/libexec/java_home -V'

alias rv='rbenv'
alias rvg='rbenv shell $(rbenv global)'
alias rvl='rbenv shell $(rbenv local)'

alias gr='./gradlew'
alias depends='./gradlew dependencies > dependencies.txt'
alias idea='open -na "IntelliJ IDEA.app" --args "$@"'
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

# System
alias zzn='sudo pmset -a sleep 0; sudo pmset -a ttyskeepawake 1; sudo pmset -a tcpkeepalive 1; sudo pmset -a hibernatemode 0; sudo pmset -a disablesleep 1;'
alias zzy='sudo pmset -a sleep 11; sudo pmset -a ttyskeepawake 1; sudo pmset -a tcpkeepalive 1; sudo pmset -a hibernatemode 3; sudo pmset -a disablesleep 0;'
alias zzz='sudo pmset -a sleep 11; sudo pmset -a ttyskeepawake 0; sudo pmset -a tcpkeepalive 0; sudo pmset -a hibernatemode 25; sudo pmset -a disablesleep 0;'
alias night='sudo pmset sleepnow'
function interfaceips() { ifconfig -lu | tr -s ' ' \\n | /usr/bin/xargs -L1 ipconfig getifaddr; }
alias wan='ssh router /home/fallalex/toggle-wan'

