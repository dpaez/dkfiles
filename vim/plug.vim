call plug#begin('~/.vim/plugged')

Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'a'
if executable('ag')
    let g:ctrlp_use_caching = 0
    set grepprg=ag\ --nogroup\ --nocolor\ --hidden\ --ignore\ node_modules\
    let g:ctrlp_user_command = 'ag %s -l --hidden --ignore .git --ignore node_modules -g ""'
else
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
    let g:ctrlp_prompt_mappings = {
                \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
                \ }
endif

" Better way to work with copy and paste in vim
Plug 'svermeulen/vim-easyclip'

" A tree explorer plugin for vim.
Plug 'scrooloose/nerdtree'
map <Leader>n :NERDTreeToggle<CR>
let g:NERDTreeMouseMode = 2
" let g:NERDTreeMapMenu='M'

" Git support for nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin'

" Git support in vim
Plug 'tpope/vim-fugitive'
" fugitive options: Gdiff split in vertical mode by default
set diffopt+=vertical

" Is all about surroundings: parentheses, brackets, quotes, XML tags, and more.
Plug 'tpope/vim-surround'

" Use the dot key to repeat the last command
Plug 'tpope/vim-repeat'

" Provides insert mode auto-completion for quotes, parens, brackets
Plug 'Raimondi/delimitMate'
let delimitMate_expand_cr = 1

" Editorconfig support for vim
Plug 'editorconfig/editorconfig-vim'

" Comment your code lines
Plug 'scrooloose/nerdcommenter'

" ALE: Fucking great lint plugin
Plug 'w0rp/ale', { 'do': 'npm install -g eslint_d' }
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_javascript_eslint_use_global = 1
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_linters = {
            \   'javascript': ['eslint'],
            \}
let g:ale_dockerfile_hadolint_use_docker = 'yes'
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
highlight link ALEWarningSign String
highlight link ALEErrorSign Title
let g:ale_fixers = {
    \   'javascript': ['eslint'],
    \   'ruby': ['rubocop']
    \}
nnoremap <C-f> :ALEFix<CR>

" Status line with bufferline support
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = 'dracula'
let g:airline_left_sep = ' 〉  '
let g:airline_right_sep = ' 〈 '
let g:airline_section_warning = ''
let g:airline_section_y = ''
let g:airline_section_x = ''
let g:airline_extensions = ['tabline', 'branch', 'ale']
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_mode_map = {
    \ '__': '-',
    \ 'c' : 'C',
    \ 'i' : 'I',
    \ 'ic': 'I',
    \ 'ix': 'I',
    \ 'n' : 'N',
    \ 'ni': 'N',
    \ 'no': 'N',
    \ 'R': 'R',
    \ 'Rv': 'R',
    \ 's': 'S',
    \ 'S': 'S',
    \ '': 'S',
    \ 't': 'T',
    \ 'v': 'V',
    \ 'V': 'V'
    \}

" Emmet suport, remember: <C-Z>,
Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key='<C-Z>'

" deoplete config
let g:python3_host_prog  = '/usr/local/bin/python3'
let g:python_host_prog='/usr/local/bin/python3'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#file#enable_buffer_path = 1
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set completeopt-=preview
set completeopt+=menu,menuone,noinsert,noselect
set shortmess+=c
set pumheight=15
if has("gui_running")
    inoremap <silent><expr><C-Space> deoplete#mappings#manual_complete()
else
    inoremap <silent><expr><C-@> deoplete#mappings#manual_complete()
endif

Plug 'Shougo/echodoc.vim'
set noshowmode
let g:echodoc#enable_at_startup = 1

" Create jsdoc
Plug 'heavenshell/vim-jsdoc'
nmap <silent> <C-l> <Plug>(jsdoc)
" jnmap <silent> <C-l> <Plug>(jsdoc)lent> <C-l> <Plug>(jsdoc)sdoc autocomplete
let g:jsdoc_enable_es6 = 1

" Show whitespaces in your code and you can strip them
Plug 'ntpeters/vim-better-whitespace'
" whitestrip on save
autocmd BufWritePre * StripWhitespace

" Format your code
"Plug 'sbdchd/neoformat'
"let g:neoformat_basic_format_align = 1 " Enable alignment
"let g:neoformat_basic_format_retab = 1 " Enable tab to spaces conversion
"let g:neoformat_basic_format_trim = 1 " Enable trimmming of trailing whitespace
"let g:neoformat_try_formatprg = 1
"let g:neoformat_enabled_javascript = ['eslint_d']

" Match html tags
Plug 'Valloric/MatchTagAlways'
let g:mta_filetypes = {
            \ 'html' : 1,
            \ 'xhtml' : 1,
            \ 'xml' : 1,
            \ 'jinja' : 1,
            \ 'blade' : 1
            \}

" Move your code lines in a cool way
Plug 'matze/vim-move'

" Search plugins
Plug 'mileszs/ack.vim', { 'do': 'sudo pacman -S --noconfirm the_silver_searcher' }
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

" Amazing search and replace plugin, the command is: CtrlSF <search_value>
Plug 'dyng/ctrlsf.vim'

" Livepreview to markdown
Plug 'shime/vim-livedown', { 'do': 'npm install -g livedown' }

" mappings for ex commands
" ]q is :cnext. [q is :cprevious. ]a is :next. [b is :bprevious
Plug 'tpope/vim-unimpaired'

" Wipe a file from the buffer and keep the window/split intact
Plug 'qpkorr/vim-bufkill'
let g:BufKillCreateMappings = 0
nnoremap <C-k> :BW<CR>

" Vim sugar for the UNIX shell commands that need it the most
Plug 'tpope/vim-eunuch'

" Never be bothered by caps lock
" Plug 'suxpert/vimcaps'

" extra syntax

Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
let g:javascript_plugin_jsdoc = 1
Plug 'maxmellon/vim-jsx-pretty', { 'for': ['javascript', 'javascript.jsx'] }
let g:vim_jsx_pretty_colorful_config = 1

Plug 'alvan/vim-closetag'
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.erb,*.jsx,*.js"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.erb,*.js'


" Devicons in the files
Plug 'ryanoasis/vim-devicons'
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsEnableFolderExtensionPatternMatching = 1

function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
    return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

""Plug 'styled-components/vim-styled-components', { 'branch': 'rewrite' }
"Plug 'jwalton512/vim-blade'
"Plug 'othree/html5.vim'
"Plug 'keith/tmux.vim'
Plug 'dag/vim-fish'
Plug 'rust-lang/rust.vim'
"Plug 'chase/vim-ansible-yaml'
"Plug 'neovimhaskell/haskell-vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'tpope/vim-haml'
Plug 'cespare/vim-toml'

" themes
Plug 'dracula/vim'
"Plug 'NLKNguyen/papercolor-theme'
"Plug 'mhartington/oceanic-next'
"let g:oceanic_next_terminal_bold = 1
"let g:oceanic_next_terminal_italic = 1
"Plug 'joshdick/onedark.vim'

" Pencil is a plugin for writing prose (eg: md) on Vim. Helps with soft breaks
Plug 'reedes/vim-pencil'


call plug#end()

"denite configuration
"call denite#custom#var('file_rec', 'command',
"\ ['ag', '--hidden', '--ignore', '.git',
"\ '--ignore', 'node_modules', '--follow',
"\ '--nocolor', '--nogroup', '-g', ''])
