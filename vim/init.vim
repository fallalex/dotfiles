if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent! curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

autocmd vimenter * ++nested colorscheme gruvbox

" change from the default '\'
let mapleader = ","

" more usable help
autocmd filetype help nnoremap <buffer><cr> <c-]>
autocmd filetype help nnoremap <buffer><bs> <c-T>
autocmd filetype help nnoremap <buffer>q :q<CR>
autocmd filetype help set nonumber
noremap <leader>th :tab help 

" Quick edit/source init.vim
noremap <silent> <leader>ie :tabe $MYVIMRC<CR>
noremap <silent> <leader>is :source $MYVIMRC<CR>

" Save undo info, auto read
" use ':e' to reload the page
call mkdir($HOME.'/.vim', 'p', 0770)
call mkdir($HOME.'/.vim/undo', 'p', 0700)
set mouse=a
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
nnoremap <silent> <leader>sy
             \ : if exists("syntax_on") <BAR>
             \    syntax off <BAR>
             \ else <BAR>  
             \    syntax enable <BAR>
             \ endif<CR>   

autocmd BufEnter,BufRead,BufNewFile *.md set filetype=markdown
autocmd BufReadPost *.justfile set syntax=just

let g:rzipPlugin_extra_ext = '*.pak'

let g:vimwiki_global_ext = 0
let wiki_1 = {}
let wiki_1.path = '~/vimwiki/'
" let wiki_1.syntax = 'markdown'
let wiki_1.automatic_nested_syntaxes  = 1
let wiki_1.ext ='.wik'
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
set nrformats+=alpha

fun! TrimTail()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
command! TrimTail call TrimTail()
nmap <silent> <leader>ee :call TrimTail()<CR>
nmap <silent> <leader>et :retab<CR>
nmap <silent> <leader>vl :set number! <bar> set relativenumber!<CR>
nmap <silent> <leader>vw :set wrap!<CR>
nmap Q :q!<CR>
autocmd BufWritePre,FileWritePre *.py :call TrimTail()
set nofixeol

noremap <silent> <leader>rm :call delete(expand('%')) <bar> bdelete! <bar> q!<CR>

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_code_completion_enabled = 1

" ============================================================================
" FZF
" ============================================================================
if exists('$TMUX')
  let g:fzf_layout = { 'tmux': '-p90%,60%' }
else
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
endif

" All files
command! -nargs=? -complete=dir AF
  \ call fzf#run(fzf#wrap(fzf#vim#with_preview({
  \   'source': 'fd --type f --hidden --follow --exclude .git --no-ignore . '.expand(<q-args>)
  \ })))

command! -bar MoveBack if &buftype == 'nofile' && (winwidth(0) < &columns / 3 || winheight(0) < &lines / 3) | execute "normal! \<c-w>\<c-p>" | endif
nnoremap <silent> <leader><leader> :MoveBack<BAR>Files<CR>
nnoremap <silent> <leader><Enter>  :MoveBack<BAR>Buffers<CR>
nnoremap <silent> <leader>l        :Lines<CR>
xnoremap <silent> <leader>rg       y:Rg <C-R>"<CR>
nnoremap <silent> <leader>rg       :Rg <C-R><C-W><CR>
nnoremap <silent> <leader>RG       :Rg <C-R><C-A><CR>
nnoremap <silent> <leader>`        :Marks<CR>
nnoremap Y y$

" Rerun rg interactive
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let options = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  let options = fzf#vim#with_preview(options, 'right', 'ctrl-/')
  call fzf#vim#grep(initial_command, 1, options, a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" ============================================================================
" Plugin configuration
" ============================================================================
let g:airline_theme='gruvbox'
let g:airline_gruvbox_bg = 'dark'
let g:VimuxUseNearest = 0
let g:task_default_prompt  = ['due', 'scheduled', 'tag', 'description']
let g:indent_guides_enable_on_vim_startup = 1

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

" ============================================================================
" Plugins
" ============================================================================
call plug#begin(stdpath('data') . '/plugged')
Plug '~/.local/share/fzf'
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'tpope/vim-fugitive'
Plug 'michaeljsmith/vim-indent-object'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'vimwiki/vimwiki'
" Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'majutsushi/tagbar'
Plug 'sheerun/vim-polyglot'
Plug 'lbrayner/vim-rzip'
Plug 'morhetz/gruvbox'
Plug 'junegunn/vim-easy-align'
call plug#end()

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
