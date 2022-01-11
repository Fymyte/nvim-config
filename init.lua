-------------------------------------------------------------------------------
-- FILE: init.lua
-- AUTHORS: @Fymyte - https://github.com/Fymyte
-------------------------------------------------------------------------------

local cmd = vim.cmd
local g = vim.g

-- Do not source plugins if packer is not installed
if require 'user.packer_bootstrap'.installed() then
  return
end
vim.g.mapleader = ';'     -- remap leader key to ';'
vim.g.log_level = 'warn'

-- Enable plugins
require('plugins')
require('notify').setup({ stages = 'slide', timeout = 3000 })
vim.notify = require('notify')
local utils = require('utils')

-------------------
-- Keymaps
-------------------

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

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
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

-- nvim_cmp breaks firenvim for now
if not g.started_by_firenvim then
  require('completion')
end

-------------------
-- Firenvim
-------------------

if g.started_by_firenvim then
  g.firenvim_config = {
    globalSettings = {
      alt = 'all',
    },

    localSettings = {
      -- Don't turn firenvim on by default
      ['.*'] = {
        takeover = 'never',
      },
      ['https?://github.com/.*'] = {
        cmdline = 'firenvim',
        priority = 0,
        takeover = 'always',
      },
   }
  }
end

-------------------
-- NvimLSP
-------------------

require('lsp')

--------------------------------------------
-- Curstom commands
--------------------------------------------

-- Quickly open config folder in nerd-tree
cmd( [[command! Config execute 'vs ~/.config/nvim/']] )
-- Easely source config without leaving vim
cmd( [[command! SourceConfig execute 'source ~/.config/nvim/init.lua']] )
-- Easely open Dotfiles directory
cmd( [[command! DotFiles execute 'vs ~/.config']] )
-- Quickly change directory in NERDTree with path completion
cmd( [[command! -nargs=1 -complete=dir NCD NERDTree | cd <args> | NERDTreeCWD]] )

cmd( [[com! SynGroup echo {l,c,n ->
        \   'hi<'    . synIDattr(synID(l, c, 1), n)             . '> '
        \  .'trans<' . synIDattr(synID(l, c, 0), n)             . '> '
        \  .'lo<'    . synIDattr(synIDtrans(synID(l, c, 1)), n) . '> '
        \ }(line("."), col("."), "name")]] )
