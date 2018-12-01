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

let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

fun! TrimTail()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
noremap K :call TrimTail()<CR>

call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'blindFS/vim-taskwarrior'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()
