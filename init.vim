if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent! curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" change from the default '\'
let mapleader = ","

" more usable help
autocmd filetype help nnoremap <buffer><cr> <c-]>
autocmd filetype help nnoremap <buffer><bs> <c-T>
autocmd filetype help nnoremap <buffer>q :q<CR>
autocmd filetype help set nonumber
noremap <leader>th :tab help

" Quick edit/source init.vim
noremap <silent> <leader>ie :vsplit $MYVIMRC<CR>
noremap <silent> <leader>is :source $MYVIMRC<CR>

" Save undo info, auto read
" use ':e' to reload the page
call mkdir($HOME.'/.vim', 'p', 0770)
call mkdir($HOME.'/.vim/undo', 'p', 0700)
set undodir=~/.vim/undo
set undofile
set hidden
set autoread
set noswapfile
set writebackup

" Make VIM remember position in file after reopen
 if has("autocmd")
   au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Highlighting
fun! s:EightyLine()
    if !exists('w:eightyline')
        let w:eightyline = 1
        :set colorcolumn=80
        :highlight ColorColumn ctermbg=red
    else
        unl w:eightyline
        :set colorcolumn=80
        :highlight ColorColumn NONE
    endif
endfunction
nnoremap <leader>sh :call<SID>EightyLine()<cr>
set hlsearch
nmap <silent> <Esc> <Esc>:nohlsearch<CR>
set nospell
nnoremap <leader>ss :set spell!<CR>

" change how mutt mail is displayed in vim
autocmd BufNewFile,BufRead ~/.mutt/temp* set noautoindent filetype=mail wm=0 tw=78 nonumber digraph nolist nopaste

autocmd BufEnter,BufRead,BufNewFile *.md set filetype=markdown
let g:vimwiki_global_ext = 0
let wiki_1 = {}
let wiki_1.path = '~/vimwiki/'
let wiki_1.syntax = 'markdown'
let wiki_1.ext ='.md'
let wiki_1.diary_rel_path = 'journal/'
let wiki_1.diary_index = 'journal'
let wiki_1.diary_header = 'Journal'
" desc, asc
let wiki_1.diary_sort = 'desc'
let g:vimwiki_list = [wiki_1]

set nocompatible
syntax on
filetype indent plugin on
set scrolloff=17
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set number relativenumber
set background=dark

fun! TrimTail()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
command! TrimTail call TrimTail()
nmap <silent> <leader>ee :call TrimTail()<CR>
nmap <silent> <leader>et :retab<CR>
autocmd BufWritePre,FileWritePre *.py :call TrimTail()
autocmd BufWritePre,FileWritePre *.md :call TrimTail()

noremap <silent> <leader>rm :call delete(expand('%')) <bar> bdelete! <bar> q!<CR>

" Plugin configuration
let g:airline_theme = 'solarized'
let g:airline_solarized_bg = 'dark'
let g:VimuxUseNearest = 0
let g:task_default_prompt  = ['due', 'scheduled', 'tag', 'description']
let g:indent_guides_enable_on_vim_startup = 1
let g:VtrStripLeadingWhitespace = 0
let g:VtrClearEmptyLines = 0
let g:VtrAppendNewline = 1
let g:VtrOrientation = "h"
let g:VtrPercentage = 45
let g:VtrClearOnReattach = 0
let g:VtrClearOnReorient = 0
nmap <silent> <leader>ro :VtrOpenRunner<CR>
nmap <silent> <leader>rk :VtrKillRunner<CR>

nmap <silent> <leader>rd :VtrDetachRunner<CR>
nmap <silent> <leader>ra :VtrReattachRunner<CR>
nmap <silent> <leader>rf :VtrFocusRunner<CR>

nmap <silent> <leader>rc :VtrSendCommandToRunner<CR>
nmap <silent> <leader>rw :VtrFlushCommand<CR>

nmap <silent> <leader>rs :VtrResizeRunner<CR>
nmap <silent> <leader>rr :VtrReorientRunner<CR>

" Commented lines bellow generate tmuxline_snapshot
" :Tmuxline vim_statusline_1
" :TmuxlineSnapshot ~/dotfiles/tmuxline_snapshot
" manually move the changes from the old file to the new
" then overwrite the old file
let g:tmuxline_powerline_separators = 0
let g:tmuxline_preset = {
     \'a'    : '#{=6:session_name}',
     \'b'    : '#P:#{=6:pane_current_command}',
     \'c'    : ' ',
     \'win'  : '#I:#{=6:window_name}',
     \'cwin' : '#I:#{=6:window_name}#F',
     \'x'    : '%b-%a',
     \'y'    : '%m-%d',
     \'z'    : '%H:%M'}

" Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'roxma/vim-tmux-clipboard'
Plug 'edkolev/tmuxline.vim'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'tpope/vim-fugitive'
Plug 'michaeljsmith/vim-indent-object'
Plug 'Yggdroot/indentLine'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-user'
Plug 'christoomey/vim-tmux-runner'
Plug 'vimwiki/vimwiki'
Plug 'tbabej/taskwiki'
Plug 'blindFS/vim-taskwarrior'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'majutsushi/tagbar'
call plug#end()
