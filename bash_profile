# .bash_profile
# ln -sf $HOME/scripts/shell_environment/bash_profile $HOME/.bash_profile
#

source "$HOME/scripts/link_scripts/link_scripts.sh"
PATH=$PATH:/usr/local/sbin

# include preexec for running commands before or after prompt
curl -s https://raw.githubusercontent.com/rcaloras/bash-preexec/master/bash-preexec.sh -o ~/.bash-preexec.sh
source "$HOME/.bash-preexec.sh"
preexec() { echo;}
precmd()  { echo; history -a; }

## HISTORY Setup
export HISTCONTROL=ignorespace:erasedups # duplicate entries avoided
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
export HISTTIMEFORMAT='%F %T '           # add datetime to history
shopt -s histappend                      # append to history, don't overwrite it

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export PS1='\[`[ $? = 0 ] && X=2 || X=1; tput setaf $X`\]\D{%F %T}\[`tput sgr0`\] \u@\h:$PWD\n'
export PS2=""

# load all the auto complet files for homebrew
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

## setup fuck alias for "thefuck" to correct invalid commands
eval $(thefuck --alias)

## User Editor
export EDITOR=/usr/bin/vim

# general
alias dt='date "+%F %T"'
alias c='clear'
alias ll='ls -FlAh'
alias ~="cd ~"
alias cd..='cd ../'
alias ..='cd ../'
alias vi='vim'
alias echopath='echo -e ${PATH//:/\\n}'
alias cc="clear && printf '\e[3J'"
alias ip='curl -s http://checkip.amazonaws.com'

## Mac specific
alias showhide='x=$(defaults read com.apple.finder AppleShowAllFiles); x=$(((x+1)%2)); defaults write com.apple.finder AppleShowAllFiles ${x}; killall Finder /System/Library/CoreServices/Finder.app'
alias macf='open -a Finder ./'
alias bye='/System/Library/CoreServices/"Menu Extras"/User.menu/Contents/Resources/CGSession -suspend'

## password
alias gen2fa='pass 2FA | gen2fa'
function genpass { local length="${1:-30}"; pwgen -1syN 625 | tr -d '[:space:]' | cut -c1-$length; }
export -f genpass

## ledger
alias led='ledger --init-file ~/gdrive/Config/ledger/ledgerrc -f ~/gdrive/Config/ledger/main.journal'
