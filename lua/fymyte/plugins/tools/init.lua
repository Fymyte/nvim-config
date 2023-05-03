return {
  -- More icons
  'nvim-tree/nvim-web-devicons',

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
          require('null-ls').builtins.formatting.yapf,
          require('null-ls').builtins.code_actions.shellcheck,
        },
      }
    end,
  },

  {
    'saecki/crates.nvim',
    keys = {
      {
        '<leader>tc',
        function()
          require('crates').toggle()
        end,
        desc = '[T]oggle [C]rates',
      },
      {
        '<leader>cv',
        function()
          require('crates').show_versions_popup()
        end,
        desc = '[C]rates [V]ersions',
      },
      {
        '<leader>cf',
        function()
          require('crates').show_features_popup()
        end,
        desc = '[C]rates [F]eatures',
      },
      {
        '<leader>cd',
        function()
          require('crates').show_dependencies_popup()
        end,
        desc = '[C]rates [D]dependencies',
      },
    },
    opts = {
      null_ls = { enabled = true },
    },
    config = function(_, opts)
      require('crates').setup(opts)
      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = 'Cargo.toml',
        callback = function(opts)
          local crates_commands = {
            toggle = require('crates').toggle,
            reload = require('crates').reload,
            ['show versions'] = require('crates').show_versions_popup,
            ['show features'] = require('crates').show_features_popup,
            ['show dependencies'] = require('crates').show_dependencies_popup,
            ['update'] = require('crates').update_crate,
            ['update all'] = require('crates').update_all_crates,
            ['upgrade'] = require('crates').upgrade_crate,
            ['upgrade all'] = require('crates').upgrade_all_crates,
            ['open homepage'] = require('crates').open_homepage,
            ['open repository'] = require('crates').open_repository,
            ['open documentation'] = require('crates').open_documentation,
            ['open crate'] = require('crates').open_crates_io,
          }
          vim.api.nvim_buf_create_user_command(opts.buf, 'Crates', function(args)
            local cmd = vim.trim(args.args or '')
            if crates_commands[cmd] then
              crates_commands[cmd]()
            else
              vim.notify('no such command ' .. cmd)
            end
          end, {
            nargs = '*',
            desc = 'Rust crates',
            complete = function(_, line)
              if line:match '^%s*Crates %w+ ' then
                return {}
              end
              local prefix = line:match '^%s*Crates (%w*)' or ''
              return vim.tbl_filter(function(key)
                return key:find(prefix) == 1
              end, vim.tbl_keys(crates_commands))
            end,
          })
        end,
      })
    end,
  },
}
