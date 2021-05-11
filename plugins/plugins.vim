call plug#begin('~/.config/nvim/autoload/plugged')
""""""""""""""""""""""""
" Utils
""""""""""""""""""""""""
    Plug 'ryanoasis/vim-devicons'                                                   " add icons before files and folders
    Plug 'scrooloose/nerdtree'                                                      " file explorer 
    Plug 'dyng/ctrlsf.vim'                                                          " edit same text in multiple files (also subfolders)
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    Plug 'tpope/vim-fugitive'                                                       " git commands inside vim
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}                             " multiple cursors
    Plug 'Shougo/context_filetype.vim'                                              " Handle multiple filetype in one file

""""""""""""""""""""""""
" Langage supports
""""""""""""""""""""""""
    Plug 'octol/vim-cpp-enhanced-highlight'                                         " CPP lang
    Plug 'rust-lang/rust.vim'                                                       " Rust lang
    Plug 'arzg/vim-rust-syntax-ext'                                                 " Rust better syntax highlighting
    Plug 'sheerun/vim-polyglot'                                                     " Better Syntax Support
    Plug 'jiangmiao/auto-pairs'                                                     " Auto pairs for '(' '[' '{'
    " Plug 'ycm-core/YouCompleteMe'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'w0rp/ale'                                                                 " ale linter

    Plug 'evanleck/vim-svelte'                                                      " svelte lang
    Plug 'HerringtonDarkholme/yats.vim'                                             " typescript lang

""""""""""""""""""""""""
" Configs supports
""""""""""""""""""""""""
    Plug 'moon-musick/vim-i3-config-syntax'                                         " i3 config
    Plug 'cantoromc/vim-rasi'                                                       " rofi configs
    Plug 'fladson/vim-kitty'                                                        " kitty config   
    
""""""""""""""""""""""""
" Visual
""""""""""""""""""""""""
    Plug 'ap/vim-css-color'                                                         " color background for rbg, hex and anssi colors
    Plug 'kaicataldo/material.vim', { 'branch': 'main' }                            " Material colorscheme for vim 
    Plug 'itchyny/lightline.vim'                                                    " better status line
    Plug 'maximbaz/lightline-ale'                                                   " ale support for lightline
    Plug 'mhinz/vim-startify'                                                       " better vim startup screen    

call plug#end()
