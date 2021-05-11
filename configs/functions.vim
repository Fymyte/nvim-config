""""""""""""""""""""""""""""""""""""""""""""
" File: functions.vim
" Author: Fymyte - @Fymyte
""""""""""""""""""""""""""""""""""""""""""""

" Show syntax group (useful for theming and syntax highlighting tweeks)
function! SynGroup()                                                            
    let l:s = synID(line('.'), col('.'), 1)                                       
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

" Quickly open config folder in nerd-tree
command! Config execute 'vs ~/.config/nvim/'
" Easely source config without leaving vim
command! SourceConfig execute 'source ~/.config/nvim/init.vim'
" Easely open Dotfiles directory
command! DotFiles execute 'vs ~/.config'
