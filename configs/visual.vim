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
  \   'gitbranch': 'GitBranch'
  \ },
  \ }

function! GitBranch()
  return '⎇  '.FugitiveHead()
endfunction

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

aug md_ft_detection
  au!
  au BufNewFile,BufRead Scratch set filetype=markdown
aug end

"""""""""""""""""""
" Multiple filetypes
"""""""""""""""""""
" if !exists('g:context_filetype#same_filetypes')
"   let g:context_filetype#filetypes = {}
" endif
" 
" let g:context_filetype#filetypes.svelte =
" \ [
" \   {'filetype' : 'javascript', 'start' : '<script>', 'end' : '</script>'},
" \   {
" \     'filetype': 'typescript',
" \     'start': '<script\%( [^>]*\)\? \%(ts\|lang="\%(ts\|typescript\)"\)\%( [^>]*\)\?>',
" \     'end': '',
" \   },
" \   {'filetype' : 'css', 'start' : '<style \?.*>', 'end' : '</style>'},
" \ ]

let g:svelte_preprocessor_tags = [
  \ { 'name': 'postcss', 'tag': 'style', 'as': 'scss' },
  \ { 'name': 'ts', 'tag': 'script', 'as': 'typescript' }
  \ ]
" You still need to enable these preprocessors as well.
let g:svelte_preprocessors = []
let g:svelte_preprocessors = ['postcss', 'typescript', "ts"]
