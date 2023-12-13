source "$FZF_ROOT/shell/completion.zsh"

# Make sure to disable any "^R" bindings for atuin
# TODO: automate this to avoid reversion on updates
source "$FZF_ROOT/shell/key-bindings.zsh"

# https://github.com/junegunn/fzf/wiki/Configuring-fuzzy-completion
# Keep default TAB completion and bind fzf completion 
export FZF_COMPLETION_TRIGGER=''
bindkey -M vicmd '^T' fzf-completion
bindkey -M viins '^T' fzf-completion
bindkey '^I' $fzf_default_completion  # set binding back to original


# morhetz/gruvbox
export FZF_DEFAULT_OPTS='--bind=esc:cancel --color=bg+:#3c3836,bg:#32302f,spinner:#fb4934,hl:#928374,fg:#ebdbb2,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,fg+:#ebdbb2,prompt:#fb4934,hl+:#fb4934'

export FD_DEFAULT_OPTIONS="-uu --follow --exclude .git"
export FZF_DEFAULT_COMMAND="fd $FD_DEFAULT_OPTIONS"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
_fzf_default() { eval "fd $FD_DEFAULT_OPTIONS -t d ." }

