
function swap() {
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}


function mk() { mkdir -p "$1" && cd "$1"; }

function xsion() { fd -t f | rg ".*/.*(\..+$)" -or '$1' | sort | uniq -c | sort -rn | head; }
# TODO: alias p='den'
#
case "$OSTYPE" in
    darwin*)
        function openapp() {
            locate .app | rg -N ".*\.app$" | fzf | gxargs -i open {}
            # open "$(fd -t d ".app" /Applications | rg -Ni "$@")"
        }
        alias o='openapp'
        alias xargs='gxargs'
        alias readlink='greadlink'
        alias realpath='grealpath'
        alias gupdatedb='gupdatedb --localpaths=$HOME --output=$HOME/tmp/locatedb --prunepaths=$HOME/Library'
        alias glocate='glocate --database=$HOME/tmp/locatedb'
        alias dnsflush='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder'
        function spotlight { mdfind "kMDItemDisplayName == '$@'wc"; }
    ;;
    # linux*)
    # ;;
    # dragonfly*|freebsd*|netbsd*|openbsd*)
    # ;;
esac

# https://unix.stackexchange.com/questions/335145/using-zsh-autocompletion-for-alias
alias ta=task
compdef ta=task
alias ss='rm -f ~/.config/zsh/.zcompdump; exec zsh -l'
alias v="$EDITOR"
alias vim="$EDITOR"
alias vimr="$EDITOR --noplugin -R -c 'syn off'"
alias vz="$EDITOR $HOME/.zshrc"
alias ff='fzf'
alias viles="$PAGER"
alias dt='date "+%F %T"'
alias dat='date "+%Y%m%d"'
alias journal="$EDITOR ~/vimwiki/journal/$(date '+%F').md"
alias wiki="$EDITOR -c VimwikiIndex"
# you can pass -- as an argument, and all subsequent arguments are treated as operands and not options, even if they begin with a dash
alias -- -='cd -'
alias ~='cd ~'
alias ..='cd ../'
alias ppath='print -l $path'
alias pfpath='print -l $fpath | xargs -i fd . -t f -t l {}'
alias otpass='pass otp.yaml | otpass.py'
alias otp='otpass'
#alias led='ledger --init-file ~/ledger/ledgerrc -f ~/ledger/ledger'
#alias ecu=' sshpass -p `pass ibm | head -1` ssh ecurep'
#alias ibmproxy='autossh -M 0 -qND localhost:8088 ibmvpn'
alias ls='gls -h --time-style=long-iso --color=auto'
alias ll='ls -Fl --group-directories-first'
alias lt='ls -Fltr --time-style=full-iso'
alias l.='ls -Fld'
alias mv='mv -iv'
alias cp='cp -iv'
alias files='fd -t f $(pwd)'
alias g='git'
compdef g=git
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
alias bmftp='lftp ftp.bluemedora.com -e "cd bmftpuser; cls -lh --sort=date"'
alias vmftp='lftp ftpsite.vmware.com'
alias pyhist="cat ~/.ptpython/history | sed 's/^\+//' | sed 's/^\#.*//' | tr -s '\n'"
alias wr='curl -s wttr.in | ghead -n -2'
alias rad='curl -s "https://radar.weather.gov/Conus/Loop/NatLoop.gif" > radar.gif; mpv --loop-file=inf --fs radar.gif'
alias deploylogs="log show --info --debug --last 30m --style compact --predicate 'subsystem == \"com.bluemedora.vrops-deploy.daemon\"'"
alias bw='bw --session `den -sn`'
alias ppjson='python -m json.tool'
alias sshp='ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no'
alias ssh-cp-id-p='ssh-copy-id -o PreferredAuthentications=password -o PubkeyAuthentication=no'
alias hr='fc -RI' # read hist from file
alias hl='fc -li -20' # local shell hist
alias ht="tail $HISTFILE"
alias u='aunpack'
alias pt='ptpython3'
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


