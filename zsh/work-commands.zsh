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
