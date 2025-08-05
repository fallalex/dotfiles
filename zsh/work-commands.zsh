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

alias proj='fzfcd "" "$HOME/repos/gitlab.eng.vmware.com"'
alias glreplica='fzfcd "" "$TVS_ACTIVE_PROJECTS_REPLICA"'
alias glclone='gclonecd $(glval $TVS_PROJECTS ssh_url_to_repo | fzf)'
alias glproject='glval $TVS_PROJECTS path | rg -q "^$(reponame)\$"'
alias glopen='glval $TVS_PROJECTS web_url | fzf -m --query=$(reponame) | gxargs -r -i open {}'
alias issues='glval $TVS_PROJECTS web_url | fzf -m --query=$(reponame) | gxargs -r -i open "{}/-/issues"'
function glsearch() { glab api "groups/$GITLAB_GROUP/search?scope=projects&search=$@" > $TVS_PROJECT_SEARCH}

alias vropen='open https://$(rg "(^vr\d+.*\.vmware\.com) " -Nor '$1' "$HOME/.ssh/known_hosts" | sort -r -u | fzf)'

# TODO: write something to guess web url from remote url

# Data Providers
# TODO: make this a subcommand https://stackoverflow.com/a/34748847/3843174
alias ex='exuno'
alias check='./gradlew clean && exuno check'
alias dp='fzfcd ".*-dp$" "$HOME/repos/gitlab.eng.vmware.com"'
alias dpjar='fd -ua -tf -e jar -p build/jar'
alias dpjarcp='dpjar | sd "\n" "" | pbcopy'
alias dplog='dplog=$COLLECTIONS_DIR/$(reponame)/$(fd -tf -e log --base-directory "$COLLECTIONS_DIR/$(reponame)" | sort -rn | fzf -0 -1); if [ -f $dplog ]; then $EDITOR "$dplog"; fi'

# Management Packs
alias vr='vrops'
alias nondis='buildlib=$(fd -uupt d "/build/.*\.eudp/lib"); fd -p -t f -t l "non.*distributable.*/.*\.jar" -x cp {} $buildlib'
alias mp='fzfcd ".*-mp$" "$HOME/repos/gitlab.eng.vmware.com"'
alias pak='fd -u -tf -e pak'
alias pakcp='pak | fzf -0 -1 | gxargs -r greadlink -f | sd "\n" "" | pbcopy'
alias deplog='vrops deploy-logs last "$@"'

function vropsboxes() { rg "(^vr\d+.*\.vmware\.com) " -Nor '$1' "$HOME/.ssh/known_hosts" | sort -u }
alias vropen='vropsboxes | fzf -m | gxargs -r -i open https://{}'
alias vrssh='ssh $(vropsboxes | fzf)'

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

function bp-build() {
    local original_dir=$PWD
    # TODO make a work var for the repo path
    # TODO make var for $HOME/bin
    # TODO make var for $HOME/bin/completions
    builtin cd /Users/afall/repos/bp/bindplane-op-enterprise
    go build -o $HOME/bin/bindplane ./cmd/bindplane/main.go
    builtin cd $HOME/bin/
    chmod +x ./bindplane
    ./bindplane completion zsh > $HOME/bin/completion/_bindplane
    builtin cd "$original_dir"
}

function tagassets() {
    gh release list --limit 100 --json tagName -q '.[] | .tagName' | \
    fzf | \
    gxargs -I {} gh release view "{}" --json assets -q '.assets[] | .url'
}

function assetln() {
    tagassets | rg -v '\.sig$' | fzf --sync -m
}

function openln() {
    rg '^(http|https)://[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,}(/\S*)?$' | gxargs open
}

function bpopln() {
    rg "/v(\d+\.\d+\.\d+)/(.*)$" -NoIr 'http://storage.googleapis.com/bindplane-op-releases/bindplane/$1/$2'
}

alias bdot-status='sudo launchctl print system/com.observiq.collector'
alias bdot-start='sudo launchctl load /Library/LaunchDaemons/com.observiq.collector.plist'
alias bdot-stop='sudo launchctl unload /Library/LaunchDaemons/com.observiq.collector.plist'
alias bdot-restart='sudo launchctl unload /Library/LaunchDaemons/com.observiq.collector.plist && sudo launchctl load /Library/LaunchDaemons/com.observiq.collector.plist'
alias bdot-tail='sudo tail -F /opt/observiq-otel-collector/log/collector.log | jq | bat -l json'
alias bdot-log='sudo jq . /opt/observiq-otel-collector/log/collector.log | bat -l json'
function bdot-installer() {
    sudo sh -c "$(curl -fsSlL 'https://github.com/observIQ/bindplane-agent/releases/latest/download/install_macos.sh')" install_macos.sh $@
}

function ramdisk-create() {
# TODO: check if exists
# create and mount tmpfs
# make 1000MB exfat ram disk from 512 bytes sectors
MYDEV=$(sudo hdiutil attach -nomount ram://$((1000*1000000/512)) | awk '{$1=$1};1')
sudo diskutil erasevolume HFS+ "RAMDISK" $MYDEV
sudo diskutil enableOwnership $MYDEV
MYMOUNT=$(df | grep $MYDEV | grep -o '/Volumes/.*$')
sudo chown -R $USER:$(id -g) "$MYMOUNT"
sudo chmod -R 777 "$MYMOUNT"

echo
echo $MYMOUNT
echo $MYDEV
}
    

funciton ramdisk-destroy() {
MYDEV=$(df | grep '/Volumes/RAMDISK$' | grep -o '^/dev/disk\d')

if diskutil info $MYDEV | grep -q "RAMDISK"; then
    echo "$MYDEV is named RAMDISK, proceeding"
else
    echo "$MYDEV is not a RAMDISK"
    exit 1
fi

diskutil unmountDisk force $MYDEV
diskutil eject $MYDEV
}
