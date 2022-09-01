local ok, _ = pcall(require, 'nvim-treesitter')
if not ok then
  return
end

local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
parser_configs.vim = {
  install_info = {
    url = '~/Documents/dev/tree-sitter-viml', -- local path or git repo
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  filetype = 'vim', -- if filetype does not agrees with parser name
}
parser_configs.gflow = {
  install_info = {
    url = '~/Documents/dev/tree-sitter-goal-flow',
    files = { 'src/parser.c' },
  },
}
parser_configs.grammar = {
  install_info = {
    url = 'https://github.com/Fymyte/tree-sitter-grammar',
    files = { 'src/parser.c' },
    branch = 'main',
  },
}

local ensure_installed = {
  'c',
  'cpp',
  'vim',
  'rust',
  'query',
  'lua',
  'javascript',
  'typescript',
  'svelte',
  'css',
  'norg',
  'rasi',
  'zig',
}

require('nvim-treesitter.configs').setup {
  ensure_installed = ensure_installed,
  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    custom_captures = {
      ['variable'] = 'Identifier',
      ['parameter'] = 'Identifier',
      --["field"] = "Identifier",
    },
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
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_event = { 'BufWrite', 'CursorHold' },
  },
}

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter' }, {
  group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
  callback = function()
    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
  end,
})
