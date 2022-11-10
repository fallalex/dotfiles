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

function vropsboxes() { rg "(^vr\d+.*\.vmware\.com) " -Nor '$1' "$HOME/.ssh/known_hosts" | sort -u }
alias vropen='vropsboxes | fzf -m | gxargs -r -i open https://{}'

function deploy() {
    pakfile=$(pak | fzf -0 -1 | gxargs -r greadlink -f)
    # TODO: exit if no pakfile
    vropsboxes | fzf -m  | gxargs -i vrops deploy -H {} -P "$pakfile" $@
}

function describe() {
    for pak in $(pak | fzf -m -0 -1); do
        # TODO: could save this to $TVS_PROJECT_DATA
        vrops dump-describe $pak > "describe-$(basename $pak .pak).xml"
    done
}

