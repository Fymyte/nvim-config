-------------------------------------------------------------------------------
-- FILE: init.lua
-- AUTHORS: @Fymyte - https://github.com/Fymyte
-------------------------------------------------------------------------------

--[[ NOTE:

Much of the configuration can be found in either:

./lua/fymyte/plugins/*
  This is where configuration for most plugins is located.
  Configurations are sourced automatically at startup

./lua/fymyte/tools/*
  Lsp/Editing tools configuration

./lua/fymyte/globals.lua
  Globally available functions/variables accros my config files

./lua/fymyte/options.lua
  Preference for vim builtin options
./lua/fymyte/keymaps.lua
  My custom keymaps

./lua/fymyte/diagnostics.lua
  Neovim builtin diagnostics configuration

./luasnippets/*
  LuaSnip snippets
--]]

-- remove navigation using space
vim.keymap.set('', '<space>', '', { noremap = true, silent = true })
vim.g.mapleader = ' '
---@type integer
vim.g.log_level = vim.log.levels.WARN -- Use this for global debugging

-- Load helper functions first to have them available for after
require 'fymyte.globals'
require 'fymyte.options'
require 'fymyte.keymaps'
require 'fymyte.diagnostics'

-- Bootstrap nvim package manager
local lazy_opts = require 'fymyte.lazy-bootstrap'
require('lazy').setup('fymyte.plugins', lazy_opts)
