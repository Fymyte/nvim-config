call plug#begin('~/.config/nvim/autoload/plugged')
""""""""""""""""""""""""
" Utils
""""""""""""""""""""""""
    Plug 'ryanoasis/vim-devicons'                                                   " add icons before files and folders
    Plug 'scrooloose/nerdtree'                                                      " file explorer 
    Plug 'dyng/ctrlsf.vim'                                                          " edit same text in multiple files (also subfolders)
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

""""""""""""""""""""""""
" Langage supports
""""""""""""""""""""""""
    Plug 'rust-lang/rust.vim'                                                       " Rust lang
    Plug 'arzg/vim-rust-syntax-ext'                                                 " Rust better syntax highlighting
    Plug 'sheerun/vim-polyglot'                                                     " Better Syntax Support
    Plug 'jiangmiao/auto-pairs'                                                     " Auto pairs for '(' '[' '{'
    Plug 'w0rp/ale'                                                                 " ale linter

""""""""""""""""""""""""
" Configs supports
""""""""""""""""""""""""
    Plug 'moon-musick/vim-i3-config-syntax'                                         " i3 config
    Plug 'cantoromc/vim-rasi'
    
""""""""""""""""""""""""
" Visual
""""""""""""""""""""""""
    " Plug 'gko/vim-coloresque' 
    Plug 'ap/vim-css-color'                                                         " color background for rbg, hex and anssi colors
    Plug 'kaicataldo/material.vim', { 'branch': 'main' }                            " Material colorscheme for vim 
    Plug 'itchyny/lightline.vim'                                                    " better status line
    Plug 'maximbaz/lightline-ale'                                                   " ale support for lightline
    Plug 'itchyny/vim-gitbranch'                                                    " allow display current git branch in lightline
 

call plug#end()
