-------------------------------------------------------------------------------
-- FILE: init.lua
-- AUTHORS: @Fymyte - https://github.com/Fymyte
-------------------------------------------------------------------------------

-- local cmd = vim.cmd
-- local g = vim.g

-- If packer is not installed, install and quit.
if not require 'user.packer_bootstrap'.installed() then
  return
end

vim.g.mapleader = ';'     -- Leader key -> ";"
vim.g.log_level = 'warn'  -- Use this for global debugging

-- Enable plugins
require('plugins')

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

vim.g.glow_border = "rounded"

-------------------
-- Markdown
-------------------

vim.g.vim_markdown_math = 1
vim.g.mkdp_browser = 'brave'

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

vim.g.vimwiki_list = { { path = '~/vimwiki/', syntax = 'markdown', ext = '.md'} }

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
      toggle_hl_groups = 'I',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'h',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_event = {"BufWrite", "CursorHold"},
  }
}

-------------------
-- NvimCmp
-------------------

-- nvim_cmp breaks firenvim for now
if not vim.g.started_by_firenvim then
  require('completion')
end

-------------------
-- Firenvim
-------------------

if vim.g.started_by_firenvim then
  vim.g.firenvim_config = {
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
