""""""""""""""""""
" Lightline
"""""""""""""""""""
set laststatus=2
set noshowmode
let g:lightline = {
  \ 'colorscheme': 'material_vim',
  \ 'active': {
  \ 'left': [ [ 'mode', 'paste' ],
  \           [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'gitbranch#name'
  \ },
  \ }

"""""""""""""""""""
" Colorscheme
"""""""""""""""""""
let g:material_terminal_italics = 1
let g:material_theme_style = 'darker-community'
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
if (has('termguicolors'))
  set termguicolors
endif
colorscheme material

"""""""""""""""""""
" i3 config highlight
"""""""""""""""""""
aug i3config_ft_detection
  au!
  au BufNewFile,BufRead ~/.config/i3/config set filetype=i3
aug end
