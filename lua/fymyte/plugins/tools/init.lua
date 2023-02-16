return {
  -- More icons
  'kyazdani42/nvim-web-devicons',

  -- Completion engine
  require 'fymyte.plugins.tools.cmp',

  -- Lsp configuration
  require 'fymyte.plugins.tools.lsp',

  -- Debug adapter
  require 'fymyte.plugins.tools.dap',

  -- Nvim external tool manager
  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
    },
    opts = {
      PATH = 'append',
      ui = {
        border = 'rounded',
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
      ensure_installed = {
        'stylua',
        'selene',
        'shfmt',
        'shellcheck',
      },
      log_level = vim.g.log_level,
    },
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require 'mason-registry'
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  },

  -- External tools integration into neovim ecosystem
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = 'williamboman/mason.nvim',
    opts = function()
      return {
        sources = {
          require('null-ls').builtins.formatting.stylua,
          require('null-ls').builtins.formatting.clang_format,
          require('null-ls').builtins.diagnostics.eslint_d,
          require('null-ls').builtins.diagnostics.selene,
          require('null-ls').builtins.formatting.prettier,
          require('null-ls').builtins.formatting.shfmt,
          require('null-ls').builtins.code_actions.shellcheck,
        },
      }
    end,
  },
}
