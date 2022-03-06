
case "$OSTYPE" in
    darwin*)
        alias o='openapp'
        alias xargs='gxargs'
        alias readlink='greadlink'
        alias realpath='grealpath'
        alias dnsflush='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder'
        alias echo='gecho'
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
alias clipq='$HOME/dotfiles/python/clipq.py'
alias cb='clipq | fzf --read0 --delimiter ";:;:;" --with-nth 2 | clipq select'

# Shell
alias ppath='print -l $path'
alias ppathl='print -l $path | xargs -i fd --base-directory {} -t x'
alias pfpath='print -l $fpath'
alias pfpathl='print -l $fpath | xargs -i fd --base-directory {} -t f -t l'
alias ss='rm -f ~/.config/zsh/.zcompdump; exec zsh -l'
alias hr='fc -RI' # read hist from file
alias hl='fc -li -20' # local shell hist
alias ht="tail $HISTFILE"

# Essentials
alias -- -='cd -'
alias ~='cd ~'
alias ..='cd ../'
alias fd='fd -uu'
alias la='fd -ad1' # list with absolute path, exa cant really do this 
alias ls='exa -ga --git --time-style iso -s modified --group-directories-first'
alias wget="wget --hsts-file /dev/null" # disable history
compdef ls=exa
alias ll='ls -l'
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
# TODO: make a function to handle .bak files
function swap() {
    local TMPFILE=tmp.$$
    /bin/mv "$1" $TMPFILE
    /bin/mv "$2" "$1"
    /bin/mv $TMPFILE "$2"
}
function mk() { mkdir -p "$1" && cd "$1"; }

# Dev
alias g='git'
compdef g=git

alias py='python'
alias pv='pyenv'
alias pvg='pyenv shell $(pyenv global)'
alias pvl='pyenv shell $(pyenv local)'
alias pyhist="cat ~/.ptpython/history | sed 's/^\+//' | sed 's/^\#.*//' | tr -s '\n'"

alias jv='jenv'
alias jvg='jenv shell $(jenv global)'
alias jvl='jenv shell $(jenv local)'
alias jvpaths='ll $HOME/.jenv/versions'
alias jvpath='ll `jenv prefix`'
alias jhomes='/usr/libexec/java_home -V'

alias rv='rbenv'
alias rvg='rbenv shell $(rbenv global)'
alias rvl='rbenv shell $(rbenv local)'

alias gr='./gradlew'
alias idea='open -na "IntelliJ IDEA.app" --args "$@"'
alias ppjson='python -m json.tool'
function todo() {rg 'TODO[:\s]+' -C 5}

# Work
function gss() {sshpass -p `den -np intranet-user` ssh gss$1}
alias fed='sshpass -p `den -np vm-federal` ssh fed'
alias vmftpd='lftp --norc -u downloadv,`den -np vmftp-downloadv` ftpsite.vmware.com'
alias vmftpi='lftp --norc -u inboundv,`den -np vmftp-inboundv` ftpsite.vmware.com'
alias ex='exuno'
alias vr='vrops'
alias nondis='buildlib=$(fd -uupt d "/build/.*\.eudp/lib"); fd -p -t f -t l "non.*distributable.*/.*\.jar" -x cp {} $buildlib'
alias vropscli='$HOME/.pyenv/versions/vropscli/bin/python3 $HOME/repos/github.com/vropscli/vropscli.py --user admin --password `den -pn vrops-box` --host '
function searchproject() { glab api "groups/28764/search?scope=projects&search=$@" }
alias isproject='searchproject $(basename $(git config --get remote.origin.url) .git)'
function timelogged() {
    for file in "$@"
    do
        echo $file
        starttime=$(rg -m1 '^(\d{4}-\d{2}-\d{2}.*?),' -Nor '$1' "${file}")
        endtime=$(tac "${file}" | rg -m1 '^(\d{4}-\d{2}-\d{2}.*?),' -Nor '$1')
        echo -n '  Start : '; echo $starttime
        echo -n '  End   : '; echo $endtime
        echo -n '  Delta : '; python -c "from datetime import datetime;f='%Y-%m-%dT%H:%M:%S';print(datetime.strptime('${endtime}',f)-datetime.strptime('${starttime}',f))"
        echo '--'
    done
}

# System
alias zzn='sudo pmset -a sleep 0; sudo pmset -a ttyskeepawake 1; sudo pmset -a tcpkeepalive 1; sudo pmset -a hibernatemode 0; sudo pmset -a disablesleep 1;'
alias zzy='sudo pmset -a sleep 11; sudo pmset -a ttyskeepawake 1; sudo pmset -a tcpkeepalive 1; sudo pmset -a hibernatemode 3; sudo pmset -a disablesleep 0;'
alias zzz='sudo pmset -a sleep 11; sudo pmset -a ttyskeepawake 0; sudo pmset -a tcpkeepalive 0; sudo pmset -a hibernatemode 25; sudo pmset -a disablesleep 0;'
alias night='sudo pmset sleepnow'
function interfaceips() { ifconfig -lu | tr -s ' ' \\n | /usr/bin/xargs -L1 ipconfig getifaddr; }


# need to make this a function
#glocate -r /.git$ | xargs gdirname
# locate .git|rg "(.*)/\.git$" -or '$1' | rg -v "(/Homebrew/|/go/|/vmware/|/\..*|/bluemedora/|/cases/|/iTerm/|/dircolors)" | gxargs -i git -C {} st

# cd () {
#     if [ `echo $1 | grep -cE "^TS00[0-9]{7}$"` -eq 1 ]
#     then
#         builtin cd "/ecurep/sf/${1:0:5}/${1:5:3}/${1}"
#     else
#         builtin cd "$@"
#     fi
# }
#

