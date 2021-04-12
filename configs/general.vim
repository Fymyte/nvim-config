" Set how many commands to remember
set history=500

" Enable filetype plugin
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" remap leader key to ';'
let mapleader=";"
nnoremap <leader>w :w!<cr>

set foldcolumn=1
