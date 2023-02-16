local ok, _ = pcall(require, 'nvim-treesitter')
if not ok then
  return
end

vim.api.nvim_set_hl(0, '@variable', { link = 'Identifier' })
vim.api.nvim_set_hl(0, '@parameter', { link = 'Identifier' })
require('nvim-treesitter.configs').setup {
  ensure_installed = ensure_installed,
  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = {},
  },
  incremental_selection = {
    enable = false,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    enable = false,
    select = {
      enable = false,
      lookahead = true,
      keymaps = {
        -- ["af"] = "@function.outer",
        -- ["if"] = "@function.inner",
        -- ["ao"] = "@parameter.outer",
        -- ["io"] = "@parameter.inner",
        -- ["ac"] = "@class.outer",
        -- ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = false,
      set_jumps = true,
      goto_next_start = {
        -- ["]m"] = "@function.outer",
        -- ["]p"] = "@parameter.inner",
        -- ["]]"] = "@class.outer",
      },
      goto_next_end = {
        -- ["]M"] = "@function.outer",
        -- ["]P"] = "@parameter.inner",
        -- ["]["] = "@class.outer",
      },
      goto_previous_start = {
        -- ["[m"] = "@function.outer",
        -- ["[b"] = "@parameter.inner",
        -- ["[["] = "@class.outer",
      },
      goto_previous_end = {
        -- ["[M"] = "@function.outer",
        -- ["[b"] = "@parameter.inner",
        -- ["[]"] = "@class.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
    lsp_interop = {
      enable = false,
      border = 'rounded',
      peek_definition_code = {
        ['<leader>df'] = '@function.outer',
        ['<leader>db'] = '@block.outer',
        ['<leader>dF'] = '@class.outer',
      },
    },
  },
}

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter' }, {
  group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
  callback = function()
    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
  end,
})
