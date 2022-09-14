
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

# Shell
alias ppath='print -l $path'
alias px='whence -pm "*"'
alias pfpath='print -l $fpath'
alias pfpathl='print -l $fpath | xargs -i fd --base-directory {} -a -t f -t l'
alias ss='rm -f $XDG_CONFIG_HOME/zsh/.zcompdump; exec zsh -l'
alias hr='fc -RI' # read hist from file
alias hl='fc -li -20' # local shell hist
alias ht="tail $HISTFILE"

# Essentials
alias -- -='cd -'
alias ~='cd ~'
alias ..='cd ../'
alias fd='fd -uu'
alias la='fd -ad1' # list with absolute path, exa cant really do this 
alias ls='exa -ga -I ".git|.DS_Store" --git --time-style iso -s modified --group-directories-first'
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
alias jvpaths='ll $HOME/.jenv/versions'
alias jvpath='ll `jenv prefix`'
alias jhomes='/usr/libexec/java_home -V'

alias rv='rbenv'
alias rvg='rbenv shell $(rbenv global)'
alias rvl='rbenv shell $(rbenv local)'

alias gr='./gradlew'
alias depends='./gradlew dependencies > dependencies.txt'
alias idea='open -na "IntelliJ IDEA.app" --args "$@"'
# alias ppjson='python -m json.tool' # use 'jq .'
function todo() {rg 'TODO[:\s]+' -C 5}

alias jq='gojq'

# Work
alias vmftpd='lftp --norc -u downloadv,`den -np vmftp-downloadv` ftpsite.vmware.com'
alias vmftpi='lftp --norc -u inboundv,`den -np vmftp-inboundv` ftpsite.vmware.com'
alias vropscli='$HOME/.pyenv/versions/vropscli/bin/python3 $HOME/repos/github.com/vropscli/vropscli.py --user admin --password `den -pn vrops-box` --host '
alias fed='sshpass -p `den -np vm-federal` ssh fed'

function gss() {
    if [ $# -eq 0 ]; then
        sshpass -p `den -np intranet-user` ssh gss
    else
        sshpass -p `den -np intranet-user` ssh gss-prd-csp-$1
    fi
}

function update-remote() {
    $DOTS_DIR/bin/update-remote $@
    cd -P .
}

function glval() {
    if [ "$#" -eq 1 ] && [ -f "$1" ]; then
        gojq -r '.[] | keys[]' "$1" | sort -u
    elif [ "$#" -ne 2 ]; then
        echo "Pass a path to a gitlab json file and a field."
    else
        if [ ! -f "$1" ]; then
            echo "$1" does not exist
            echo "Pass a path to a gitlab json file and a field."
        else
            gojq -r ".[] | .$2" "$1"
        fi
    fi
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

alias proj='fzfcd "" "$HOME/repos/gitlab.eng.vmware.com"'
alias glreplica='fzfcd ".*-[dm]p$" "$TVS_ACTIVE_PROJECTS_REPLICA"'
alias glclone='gclonecd $(glval $TVS_PROJECTS ssh_url_to_repo | fzf)'
alias glproject='glval $TVS_PROJECTS path | rg -q $(reponame)'
alias glopen='glval $TVS_PROJECTS web_url | fzf -m --query=$(reponame) | gxargs -r -i open {}'
function glsearch() { glab api "groups/$GITLAB_GROUP/search?scope=projects&search=$@" > $TVS_PROJECT_SEARCH}

alias vropen='open https://$(rg "(^vr\d+.*\.vmware\.com) " -Nor '$1' "$HOME/.ssh/known_hosts" | sort -r -u | fzf)'

# TODO: write something to guess web url from remote url

# Data Providers
# TODO: make this a subcommand https://stackoverflow.com/a/34748847/3843174
alias ex='exuno'
alias check='./gradlew clean && exuno check'
alias dp='fzfcd ".*-dp$" "$HOME/repos/gitlab.eng.vmware.com"'
alias dpjar='fd -tf -e jar -p build/jar'
alias dpjarcp='dpjar | gxargs -r greadlink -f | sd "\n" "" | pbcopy'
alias dplog='dplog=$COLLECTIONS_DIR/$(reponame)/$(fd -tf -e log --base-directory "$COLLECTIONS_DIR/$(reponame)" | sort -rn | fzf -0 -1); if [ -f $dplog ]; then $EDITOR "$dplog"; fi'

# Management Packs
alias vr='vrops'
alias nondis='buildlib=$(fd -uupt d "/build/.*\.eudp/lib"); fd -p -t f -t l "non.*distributable.*/.*\.jar" -x cp {} $buildlib'
alias mp='fzfcd ".*-mp$" "$HOME/repos/gitlab.eng.vmware.com"'
alias pak='fd -tf -e pak'
alias pakcp='pak | fzf -0 -1 | gxargs -r greadlink -f | sd "\n" "" | pbcopy'
alias deplog='vrops deploy-logs last "$@"'

function vropsboxes() { rg "(^vr\d+.*\.vmware\.com) " -Nor '$1' "$HOME/.ssh/known_hosts" }
alias vropen='vropsboxes | sort -u | fzf -m | gxargs -r -i open https://{}'

function deploy() {
    pakfile=$(pak | fzf -0 -1 | gxargs -r greadlink -f)
    # TODO: exit if no pakfile
    vropsboxes | sort -u | fzf -m  | gxargs -i vrops deploy -H {} -P "$pakfile" $@
}

function describe() {
    for pak in $(pak | fzf -m -0 -1); do
        # TODO: could save this to $TVS_PROJECT_DATA
        vrops dump-describe $pak > "describe-$(basename $pak .pak).xml"
    done
}

# System
alias zzn='sudo pmset -a sleep 0; sudo pmset -a ttyskeepawake 1; sudo pmset -a tcpkeepalive 1; sudo pmset -a hibernatemode 0; sudo pmset -a disablesleep 1;'
alias zzy='sudo pmset -a sleep 11; sudo pmset -a ttyskeepawake 1; sudo pmset -a tcpkeepalive 1; sudo pmset -a hibernatemode 3; sudo pmset -a disablesleep 0;'
alias zzz='sudo pmset -a sleep 11; sudo pmset -a ttyskeepawake 0; sudo pmset -a tcpkeepalive 0; sudo pmset -a hibernatemode 25; sudo pmset -a disablesleep 0;'
alias night='sudo pmset sleepnow'
function interfaceips() { ifconfig -lu | tr -s ' ' \\n | /usr/bin/xargs -L1 ipconfig getifaddr; }
alias wan='ssh router /home/fallalex/toggle-wan'

# cd () {
#     if [ `echo $1 | grep -cE "^TS00[0-9]{7}$"` -eq 1 ]
#     then
#         builtin cd "/ecurep/sf/${1:0:5}/${1:5:3}/${1}"
#     else
#         builtin cd "$@"
#     fi
# }
#

