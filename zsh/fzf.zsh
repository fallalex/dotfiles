# Auto-completion
# ---------------
source "$FZF_ROOT/shell/completion.zsh"

# Key bindings
# ------------
source "$FZF_ROOT/shell/key-bindings.zsh"

# https://github.com/junegunn/fzf/wiki/Configuring-fuzzy-completion
export FZF_COMPLETION_TRIGGER=''
bindkey '^T' fzf-completion
bindkey '^I' $fzf_default_completion

# morhetz/gruvbox
export FZF_DEFAULT_OPTS='--bind=esc:cancel --color=bg+:#3c3836,bg:#32302f,spinner:#fb4934,hl:#928374,fg:#ebdbb2,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,fg+:#ebdbb2,prompt:#fb4934,hl+:#fb4934'
export FD_DEFAULT_OPTIONS="-uu --follow --exclude .git"
export FZF_DEFAULT_COMMAND="fd $FD_DEFAULT_OPTIONS"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
_fzf_default() { eval "fd $FD_DEFAULT_OPTIONS -t d ." }

j() {
    # TODO: would like interactive fzf for dirs in pwd
    # this shows resent dirs and rank
    if [ "$#" -eq 0 ]; then
        zi
    else
        # gets last argument into "$1"
        shift $(($# - 1))
        if [ -f "$1" ]; then
            z $(dirname "$1")
        else
            z "$1"
        fi
    fi
}

# v() {
#     # if no args fzf file
#     # if blank close
#     true
# }

# vr() {
#     # fzf from list of files from previous rg command
#     true
# }

