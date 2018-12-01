if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

syntax on
filetype indent plugin on

highlight ColorColumn ctermbg=gray
set colorcolumn=80

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

set number relativenumber

fun! TrimTail()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
noremap K :call TrimTail()<CR>

" Plugin configuration
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:VimuxUseNearest = 0
let g:task_default_prompt  = ['due', 'description', 'tag']
" reload when focus is gained or cursor inactive
set autoread
autocmd CursorHold,CursorHoldI * checktime
autocmd FocusGained,BufEnter * checktime

" Plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'blindFS/vim-taskwarrior'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'roxma/vim-tmux-clipboard'

call plug#end()
