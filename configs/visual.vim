""""""""""""""""""
" Lightline
"""""""""""""""""""
set laststatus=2
set noshowmode

let g:lightline = {
  \ 'colorscheme': 'material_vim',
  \ 'active': {
  \ 'left': [ [ 'mode', 'paste' ],
  \           [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
  \ 'right': [ [ 'lineinfo' ],
	\            [ 'percent' ],
  \            [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
	\            [ 'fileformat', 'fileencoding', 'filetype'] ],
  \ },
  \ 'component_function': {
  \   'gitbranch': 'GitBranch',
  \   'filename': 'FullFileName'
  \ },
  \ }

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ }

function! GitBranch()
  return '⎇  '.FugitiveHead()
endfunction

" Show full path of filename
function! FullFileName()
    return expand('%')
endfunction

""""""""""""""""""
" Ale
"""""""""""""""""""
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰']
" Check Python files with flake8 and pylint.
let g:ale_linters = {
      \   'python': ['flake8', 'pyright'],
      \}
" Fix Python files with autopep8 and yapf.
let g:ale_fixers = {
      \   'python': ['autopep8', 'yapf'],
      \}
" Disable warnings about trailing whitespace for Python files.
let b:ale_warn_about_trailing_whitespace = 0
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
