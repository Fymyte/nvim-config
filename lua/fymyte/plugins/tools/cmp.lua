return {
  -- Snippet engine
  {
    'L3MON4D3/LuaSnip',
    build = 'make install_jsregexp',
    version = 'v1',
    event = 'VeryLazy',
    keys = {
      {
        mode = { 'i', 's' },
        '<C-k>',
        function()
          if require('luasnip').expand_or_jumpable() then
            require('luasnip').expand_or_jump()
          end
        end,
        desc = 'Snippet expand or jump next',
      },
      {
        mode = { 'i', 's' },
        '<C-j>',
        function()
          if require('luasnip').jumpable(-1) then
            require('luasnip').jump(-1)
          end
        end,
        desc = 'Snippet jump previous',
      },
      {
        mode = { 'i', 's' },
        '<C-l>',
        function()
          if require('luasnip').choice_active() then
            require('luasnip').change_choice(1)
          end
        end,
        desc = 'Snippet cycle choices',
      },
      {
        '<leader><leader>s',
        function()
          require('luasnip.loaders').edit_snippet_files {}
        end,
        desc = '[S]nippet reload',
      },
    },
    opts = function()
      local types = require 'luasnip.util.types'
      return {
        history = true,
        update_events = 'TextChanged,TextChangedI',
        delete_check_events = 'InsertLeave',
        enable_autosnippets = true,
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { '<-', 'Error' } },
            },
          },
        },
      }
    end,
    config = function(_, opts)
      local ls = require 'luasnip'
      ls.setup(opts)
      require('luasnip.loaders.from_lua').lazy_load {
        -- paths = { './luasnippets' },
      }
    end,
  },

  -- Completion engine
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      -- 'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      -- 'hrsh7th/cmp-nvim-lua',
      'f3fora/cmp-spell',
      { 'petertriho/cmp-git', dependencies = 'nvim-lua/plenary.nvim' },
      { 'onsails/lspkind-nvim', dependencies = 'neovim/nvim-lspconfig' },
      { 'saadparwaiz1/cmp_luasnip', dependencies = 'L3MON4D3/LuaSnip' },
      { 'rcarriga/cmp-dap', dependencies = 'mfussenegger/nvim-dap' },
      { 'saecki/crates.nvim', dependencies = 'nvim-lua/plenary.nvim' },
    },
    event = 'VeryLazy',
    opts = function()
      local cmp = require 'cmp'
      -- local window_style = {
      --   border = 'rounded',
      --   scrollbar = '║',
      --   winhighlight = 'Normal:Pmenu,FloatBorder:Normal,Search:None',
      -- }
      return {
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local kind = require('lspkind').cmp_format({
              mode = "symbol_text",
              maxwidth = 40,
            })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = "" .. strings[1] .. " "
            kind.menu = "    (" .. strings[2] .. ")"

            return kind
          end,
        },
        experimental = {
          ghost_text = {},
          native_menu = false,
        },
        mapping = {
          ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
          ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
          ['<Down>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
          ['<Up>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
          ['<c-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
          ['<c-f>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
          ['<c-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
          ['<c-y>'] = cmp.mapping.confirm { select = true },
          ['<c-e>'] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          },
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = "lazydev", group_index = 0 },
          { name = 'spell' },
          { name = 'crates' },
        }, {
          { name = 'path' },
          { name = 'buffer', keyword_length = 4 },
        }),
      }
    end,
    config = function(_, opts)
      local cmp = require 'cmp'
      cmp.setup(opts)
      require('cmp').setup.cmdline('/', {
        sources = cmp.config.sources({
          { name = 'nvim_lsp_document_symbol' },
        }, {
          { name = 'buffer' },
        }),
      })
      cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'nvim_lsp' },
          { name = 'cmdline' },
          { name = 'nvim_lua' },
        }, {
          { name = 'buffer' },
        }),
      })
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' },
        }, {
          { name = 'buffer' },
        }),
      })
      cmp.setup.filetype('norg', {
        sources = cmp.config.sources({
          { name = 'neorg' },
        }, {
          { name = 'buffer' },
        }),
      })
      cmp.setup.filetype({ 'dap-repl', 'dapui_watches', 'dapui_hover' }, {
        sources = {
          { name = 'dap' },
        },
      })

      require('cmp_git').setup {
        remotes = { 'upstream', 'fork', 'origin' },
        filetypes = { 'gitcommit', 'markdown' },
      }
    end,
  },
}
