-------------------------------------------------------------------------------
-- File: init.lua
-- Author: Fymyte - @Fymyte
-------------------------------------------------------------------------------
local opt = vim.opt
local cmd = vim.cmd
local api = vim.api
local fn = vim.fn
local g = vim.g

-- Enable plugins
require('plugins')
require('notify').setup({ stages = 'slide', timeout = 3000 })
vim.notify = require('notify')
local utils = require('utils')

---------------------------------------------
--  Global options
---------------------------------------------

g.log_level = 'warn'
-- General
opt.mouse = 'a'           -- Enable mouse usage
opt.autoread = true       -- Auto read when a file is changed from the outside
opt.history = 500         -- Set how many commands to remember
opt.foldcolumn = '1'      -- Set maximun unfolded column to 1
opt.scrolloff = 4         -- Always show 4 lines of the buffer when moving up/down
opt.number = true         -- Show line numbers
opt.relativenumber = true -- Enalble relative numbers
opt.cmdheight = 1         -- Set command window height
opt.wildignore = { '*.o', '*~', '*.pyc', '*/.git/*', '*/.hg/*', '*/.svn/*', '*/.DS_Store' }
opt.backspace = { 'eol', 'start', 'indent' } -- Configure backspace so it acts as it should act
opt.lazyredraw = true     -- Don't redraw while executing macros (good performance config)
opt.magic = true          -- Turn magic on for regex
opt.showmatch = true      -- Show matching brackets when text indicator is over them
opt.mat = 2               -- How many tenths of a second to blink when matching brackets
opt.fileformats = { 'unix', 'dos', 'mac' }
opt.timeoutlen = 500      -- Time for a key map to complete
opt.updatetime = 1000     -- Time for `CursorHold` event to trigger (ms)
-- show hidden characters
opt.listchars = { tab = '▸ ', trail = '·' }
opt.list = true
-- Errors
opt.errorbells = false
opt.visualbell = false
cmd([[set t_vb=]])        -- Remove terminal blinking
-- Linebreak
opt.linebreak = true
opt.textwidth = 120
-- Tabs/Spaces
opt.smartcase = true
opt.shiftwidth = 2        -- 1 tab = 2 spaces
opt.tabstop = 2
opt.expandtab = true
-- Search
opt.ignorecase = true     -- Ignore case when searching
opt.smartcase = true
opt.hlsearch = true       -- Highlight search results
opt.incsearch = true      -- Makes search act like in modern browsers
-- Persistent undo file
opt.undodir = fn.getenv('HOME') .. '/.local/share/nvim/undodir'
opt.undofile = true
-- Indentation
opt.autoindent = true
opt.smartindent = true
opt.wrap = true
opt.signcolumn = 'yes'
-- Spell checking
opt.spell = false         -- Spell checking is not set by default (define per ft using ftplugin)
opt.spelllang = { 'en_us' }
-- Enable spell checking in all buffers of the following filetypes.
cmd( [[
augroup enableFileTypeSpelling
    autocmd!
    autocmd FileType gitcommit,markdown,mkd,rst,text,vim,yaml
      \ setlocal spell
augroup END
]] )
-- Completion
opt.completeopt = { 'menu', 'menuone', 'preview' }
opt.shortmess:append('c')
-- Status line
opt.laststatus = 2        -- Always show a status line
opt.showmode = false      -- Don't show current mod (already displayed in status line)
cmd( [[
aug defaultFileType
  autocmd!
  autocmd BufNewFile,BufRead Scratch set filetype=markdown
aug end
]] )
-- Copy content of the yanked text in keyboard
cmd( [[autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg "' | endif]] )
-- Resync file from disk when gaining focus
cmd( [[au FocusGained,BufEnter * checktime]] )
-- Return to last edit position when opening files
cmd( [[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]] )

-- Disable entering in Ex mode
cmd( [[nnoremap Q <Nop>]] )

-- Make every window appears with rounded corners
-- local orig_nvim_open_win = api.nvim_open_win
-- function api.nvim_open_win(buffer, enter, config)
--   config = config or {}
--   --config.border = config.border or 'rounded'
--   for i,v in ipairs(config) do print(i,v) end
--   return orig_nvim_open_win(buffer, enter, config)
-- end

-------------------
-- Keymaps
-------------------

g.mapleader = ';'     -- remap leader key to ';'
utils.map( { 'n', '<leader>w', '<cmd>w!<cr>' } ) -- save
-- Move between windows
utils.map( { '', '<C-h>', '<cmd>wincmd h<cr>' } )
--utils.map( { '', '<C-j>', '<cmd>wincmd j<cr>' } ) -- Leave J-K for completion
--utils.map( { '', '<C-k>', '<cmd>wincmd k<cr>' } )
utils.map( { '', '<C-l>', '<cmd>wincmd l<cr>' } )
-- Move lines
utils.map( { 'n', '<M-j>', [[mz:m+<cr>`z]] } )
utils.map( { 'n', '<M-k>', [[mz:m-2<cr>`z]] } )
utils.map( { 'v', '<M-j>', [[:m'>+<cr>`<my`>mzgv`yo`z]] } )
utils.map( { 'v', '<M-k>', [[:m'<-2<cr>`>my`<mzgv`yo`z]] } )
-- Motions
utils.map( { 'n', '0', '^'}) -- use 0 to go to first char of line
utils.map( { 'n', '=', '+'})
-- Term
utils.map( { 't', '<Esc>', '<C-\\><C-n>' } )
-- Misc
utils.map( { '', '<leader>l', '<cmd>NvimTreeToggle<cr>' } )
utils.map( { '', '<leader><Space>', '<cmd>noh<cr>' } )

-------------------
-- Colorscheme
-------------------

require('colorscheme')

---------------------------------------------
-- Plugins
---------------------------------------------
-------------------
-- AutoPairs
-------------------

require('autopairs')

-------------------
-- Glow
-------------------

g.glow_border = "rounded"

-------------------
-- Markdown
-------------------

g.vim_markdown_math = 1
g.mkdp_browser = 'brave'

-------------------
-- Statusline
-------------------

-- require('statusline')

-------------------
-- telescope
-------------------

require('finder')

-------------------
-- Vimwiki
-------------------

g.vimwiki_list = { { path = '~/vimwiki/', syntax = 'markdown', ext = '.md'} }

-------------------
-- NERD (Tree/Commenter)
-------------------

g.NERDCreateDefaultMappings = 1 -- Create default mappings
g.NERDSpaceDelims = 1     -- Add spaces after comment delimiters by default
g.NERDCompactSexyComs = 0 -- Use compact syntax for prettified multi-line comments
-- g.NERDDefaultAlign = 'left' -- Align line-wise comment delimiters flush left instead of following code indentation
g.NERDCommentEmptyLines = 1 -- Allow commenting and inverting empty lines (useful when commenting a region)
g.NERDTrimTrailingWhitespace = 1 -- Enable trimming of trailing whitespace when uncommenting
g.NERDToggleCheckAllLines = 1 -- Enable NERDCommenterToggle to check all selected lines is commented or not

--require('treeviewer')

-------------------
-- i3 config highlight
-------------------
vim.cmd [[
aug i3config_ft_detection
  au!
  au BufNewFile,BufRead ~/.config/i3/config set filetype=i3
aug end
]]

-------------------
-- Treesitter
-------------------

local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
parser_config.rasi = {
  install_info = {
    url = "https://github.com/Fymyte/tree-sitter-rasi",
    branch = "main",
    files = { "src/parser.c" },
  },
  maintainers = { "@Fymyte" },
}
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
    custom_captures = {
      ["variable"] = "Identifier",
      ["variable.parameter"] = "Identifier",
      --["field"] = "Identifier",
    },
    additional_vim_regex_highlighting = true,
    disable = {},
  },
  textobjects = {
    lsp_interop = {
      enable = true,
      border = 'rounded',
      peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["<leader>dF"] = "@class.outer",
      },
    },
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
}

-------------------
-- NvimCmp
-------------------

require('completion')

-------------------
-- NvimLSP
-------------------

require('lsp')

--------------------------------------------
-- Curstom commands
--------------------------------------------

-- Quickly open config folder in nerd-tree
vim.cmd( [[command! Config execute 'vs ~/.config/nvim/']] )
-- Easely source config without leaving vim
vim.cmd( [[command! SourceConfig execute 'source ~/.config/nvim/init.lua']] )
-- Easely open Dotfiles directory
vim.cmd( [[command! DotFiles execute 'vs ~/.config']] )
-- Quickly change directory in NERDTree with path completion
vim.cmd( [[command! -nargs=1 -complete=dir NCD NERDTree | cd <args> | NERDTreeCWD]] )

vim.cmd( [[com! SynGroup echo {l,c,n ->
        \   'hi<'    . synIDattr(synID(l, c, 1), n)             . '> '
        \  .'trans<' . synIDattr(synID(l, c, 0), n)             . '> '
        \  .'lo<'    . synIDattr(synIDtrans(synID(l, c, 1)), n) . '> '
        \ }(line("."), col("."), "name")]] )
