" Plugins (vim-plug). Run :PlugInstall after changing this list.

" Install vim-plug itself on a fresh machine
let s:plug_file = expand('~/.vim/autoload/plug.vim')
if empty(glob(s:plug_file))
  silent execute '!curl -fsLo ' . s:plug_file . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Fuzzy file finder
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" A tree explorer plugin for vim.
Plug 'preservim/nerdtree'
map <Leader>n :NERDTreeToggle<CR>
let g:NERDTreeMouseMode = 2

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

" mappings for ex commands
" ]q is :cnext. [q is :cprevious. ]a is :next. [b is :bprevious
Plug 'tpope/vim-unimpaired'

" Vim sugar for the UNIX shell commands that need it the most
Plug 'tpope/vim-eunuch'

" Provides insert mode auto-completion for quotes, parens, brackets
Plug 'Raimondi/delimitMate'
let delimitMate_expand_cr = 1

" Editorconfig support (built into Neovim 0.9+, needed for Vim)
if !has('nvim')
  Plug 'editorconfig/editorconfig-vim'
endif

" Comment your code lines
Plug 'preservim/nerdcommenter'

" Status line (light) + buffers in the tabline
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ 'tabline': {'left': [['buffers']], 'right': [['close']]},
      \ 'component_expand': {'buffers': 'lightline#bufferline#buffers'},
      \ 'component_type': {'buffers': 'tabsel'},
      \ }
let g:lightline#bufferline#show_number  = 1
let g:lightline#bufferline#shorten_path = 0
let g:lightline#bufferline#unnamed      = '[No Name]'
let g:lightline#bufferline#filename_modifier = ':t'

" Emmet suport, remember: <C-Z>,
Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key='<C-Z>'

" Show whitespaces in your code and you can strip them
Plug 'ntpeters/vim-better-whitespace'
" whitestrip on save
autocmd BufWritePre * StripWhitespace

" Move your code lines in a cool way
Plug 'matze/vim-move'

" Wipe a file from the buffer and keep the window/split intact
Plug 'qpkorr/vim-bufkill'
let g:BufKillCreateMappings = 0
nnoremap <C-k> :BW<CR>

" extra syntax
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
let g:javascript_plugin_jsdoc = 1
Plug 'maxmellon/vim-jsx-pretty', { 'for': ['javascript', 'javascript.jsx'] }
let g:vim_jsx_pretty_colorful_config = 1

Plug 'alvan/vim-closetag'
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.erb,*.jsx,*.js"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.erb,*.js'

" Devicons in the files (Ghostty ships Nerd Font symbols, so no patched font needed)
Plug 'ryanoasis/vim-devicons'
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsEnableFolderExtensionPatternMatching = 1

" Pencil is a plugin for writing prose (eg: md) on Vim. Helps with soft breaks
Plug 'reedes/vim-pencil'

" theme: the Lua port only works in Neovim
if has('nvim')
  Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
else
  Plug 'catppuccin/vim', { 'as': 'catppuccin' }
endif

call plug#end()
