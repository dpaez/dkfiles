let mapleader=","
set shell=/bin/bash

source ~/.vim/plug.vim

set termguicolors
set mouse=a  " enable mouse
set mousehide  " hide when characters are typed
set showtabline=2

syntax on
set background=dark
colorscheme dracula
set lazyredraw
set nocursorline
set lazyredraw
set nobackup
set nowritebackup
set noswapfile
set ignorecase " Case sensitive search
set smartcase " Case sensitive when uc present
set nowrap " No wrap long lines
set number " Line numbers on
set relativenumber " Relative numbers on
set hidden " Allow buffer switching without saving
au BufEnter,FocusGained * checktime
set clipboard=unnamed,unnamedplus
set expandtab " Tabs are spaces, not tabs
set shiftwidth=2 " how many columns text is indented with the reindent operations (<< and >>)
set softtabstop=2 " number of spaces to use for autoindenting

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>


" search on visual selector text
function! s:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
endfunction

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>

" custom keymaps
nnoremap <C-s> :update<CR>
inoremap <C-s> <ESC>:update<CR>

" buffer config
nnoremap <C-right> :bnext<CR>
nnoremap <C-left> :bprevious<CR>

" fuck you :suspend
nnoremap <C-z> <nop>

" use hjs extension with haskell syntax
au BufNewFile,BufRead *.hjs setlocal ft=haskell

" Use a VimLeave autocommand to set the cursor style when Nvim exits
au VimLeave * set guicursor=a:block-blinkon0

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <C-Space> ?
