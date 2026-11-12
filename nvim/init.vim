set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Language servers (nvim/lua/lsp.lua)
lua require('lsp')
