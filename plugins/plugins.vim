" spellchecker: disable 
call plug#begin('~/.config/nvim/autoload/plugged')
""""""""""""""""""""""""
" Utils
""""""""""""""""""""""""
    Plug 'ryanoasis/vim-devicons'                                                   " add icons before files and folders
    Plug 'scrooloose/nerdtree'                                                      " file explorer 
    Plug 'dyng/ctrlsf.vim'                                                          " edit same text in multiple files (also subfolders)
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    Plug 'tpope/vim-fugitive'                                                       " git commands inside vim
    Plug 'rhysd/vim-clang-format'                                                   " Format c/cpp using clang format
   Plug 'preservim/nerdcommenter'                                                  " Easier commenting using keybindings

""""""""""""""""""""""""
" Langage supports
""""""""""""""""""""""""
    Plug 'jiangmiao/auto-pairs'                                                     " Auto pairs for '(' '[' '{'
    Plug 'Fymyte/hept.vim'                                                          " heptagon
    Plug 'shirk/vim-gas'                         " GNU AS
    Plug 'igankevich/mesonic'
    "Plug 'thindil/Ada-Bundle's
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}                     " treesitter
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/nvim-lsp-installer'
    Plug 'hrsh7th/cmp-nvim-lsp'                                                     " enable autocompletion
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'

    " For vsnip users.
    Plug 'hrsh7th/cmp-vsnip'                                                        " Snippets support
    Plug 'hrsh7th/vim-vsnip'

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
    Plug 'mhinz/vim-startify'                                                       " better vim startup screen    
    Plug 'jacoborus/tender.vim'                                                     " Tender colorscheme

call plug#end()
