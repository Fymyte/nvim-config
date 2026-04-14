-------------------------------------------------------------------------------
-- FILE: init.lua
-- AUTHORS: @Fymyte - https://github.com/Fymyte
-------------------------------------------------------------------------------

--[[ NOTE:

Much of the configuration can be found in either:

./lua/fymyte/globals.lua
  Globally available functions/variables across my config files

./lua/fymyte/options.lua
  Preference for vim builtin options
./lua/fymyte/keymaps.lua
  My custom keymaps

./lua/fymyte/diagnostics.lua
  Neovim builtin diagnostics configuration

./snippets/*
  My own snippets
--]]

-- remove navigation using space
vim.keymap.set('', '<space>', '', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.log_level = vim.log.levels.WARN -- Use this for global debugging

-- Load helper functions first to have them available everywhere else
require 'fymyte.globals'

-- Colorscheme
vim.pack.add {
  Utils.gh 'nvim-lua/plenary.nvim',
  { src = Utils.gh 'catppuccin/nvim', name = 'catppuccin' },
}
vim.cmd.colorscheme 'catppuccin-mocha'

-- Custom vim.opt configuration
require 'fymyte.options'
-- Additional keymaps
require 'fymyte.keymaps'
-- Builtin diagnostics configuration
require 'fymyte.diagnostics'

-- Builtin lsp configuration (include lspconfig to auto-populate vim.lsp.config)
require 'fymyte.lsp'

require('vim._core.ui2').enable { enable = true }
