return {
  -- Completion engine
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lua',
      'f3fora/cmp-spell',
      { 'petertriho/cmp-git', dependencies = 'nvim-lua/plenary.nvim' },
      { 'onsails/lspkind-nvim', dependencies = 'neovim/nvim-lspconfig' },
      { 'saadparwaiz1/cmp_luasnip', dependencies = 'L3MON4D3/LuaSnip' },
      { 'rcarriga/cmp-dap', dependencies = 'mfussenegger/nvim-dap' },
    },
    opts = function()
      local cmp = require'cmp'
      local window_style = {
        border = 'rounded',
        scrollbar = '║',
        winhighlight = 'Normal:Pmenu,FloatBorder:Normal,Search:None',
      }
      return {
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        formatting = {
          format = require('lspkind').cmp_format {
            mode = 'symbol',
            max_width = 50,
            menu = {
              buffer = '[buf]',
              nvim_lua = '[api]',
              nvim_lsp = '[LSP]',
              nvim_lsp_signature_help = '[LSP]',
              nvim_lsp_document_symbol = '[LSP]',
              path = '[path]',
              lua_snip = '[snip]',
              neorg = '[neorg]',
              spell = '[spell]',
              git = '[git]',
              dap = '[dap]',
              cmdline = '[cmd]',
            },
            preset = 'default',
          },
        },
        -- window = {
        --   documentation = window_style,
        --   completion = window_style,
        -- },
        experimental = {
          ghost_text = {},
          native_menu = false,
        },
        mapping = {
          ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
          ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
          ['<Down>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
          ['<Up>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
          ['<c-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
          ['<c-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
          ['<c-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
          ['<c-y>'] = cmp.mapping.confirm { select = true },
          ['<c-e>'] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          },
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'luasnip' },
          { name = 'nvim_lua' },
          { name = 'spell' },
        }, {
          { name = 'path' },
          { name = 'buffer', keyword_length = 4 },
        }),
      }
    end,
    config = function(_, opts)
      local cmp = require'cmp'
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
        sources = cmp.config.sources({
          { name = 'dap' },
        }),
      })

      require('cmp_git').setup {
        remotes = { 'upstream', 'fork', 'origin' },
        filetypes = { 'gitcommit', 'markdown' },
      }
    end,
  },
}
