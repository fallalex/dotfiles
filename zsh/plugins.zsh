eval "$(zoxide init zsh)"

source ~/.zplug/init.zsh
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"
# zplug load --verbose
zplug load > /dev/null


# git@github.com:mbadolato/iTerm2-Color-Schemes.git
# git clone git@github.com:seebi/dircolors-solarized.git
eval `gdircolors ~/dircolors-solarized/dircolors.ansi-dark`

