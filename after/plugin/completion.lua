if vim.g.started_by_firenvim then
  return
end

local has_cmp, cmp = pcall(require, 'cmp')
if not has_cmp then
  return
end

local cmp_config = {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  formatting = {
    -- fields = { "kind", "abbr" },
    format = require('lspkind').cmp_format {
      mode = 'symbol',
      menu = {
        buffer = '[buf]',
        nvim_lua = '[api]',
        nvim_lsp = '[LSP]',
        nvim_lsp_signature_help = '[LSP]',
        nvim_lsp_document_symbol = '[LSP]',
        path = '[path]',
        vsnip = '[snip]',
        neorg = '[neorg]',
        spell = '[spell]',
        git = '[git]',
      },
      preset = 'default',
    }
  },
  window = {
    documentation = {
      border = 'rounded',
      scrollbar = '║',
      -- zindex = 1002, -- Display documentation on top
      winhighlight = "Normal:Pmenu,FloatBorder:Normal,Search:None",
    },
    completion = {
      border = 'rounded',
      scrollbar = '║',
      winhighlight = "Normal:Pmenu,FloatBorder:Normal,Search:None",
    },
  },
  experimental = {
    ghost_text = {},
    native_menu = false,
  },
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<M-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'luasnip' },
    { name = 'nvim_lua' },
    { name = 'spell' },
    { name = 'path' },
  }, {
    { name = 'buffer', keyword_length = 4 },
  })
}

cmp.setup(cmp_config)

require'cmp'.setup.cmdline('/', {
  sources = cmp.config.sources({
    { name = 'nvim_lsp_document_symbol' }
  }, {
    { name = 'buffer' }
  })
})

cmp.setup.cmdline(':', {
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
  },
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'nvim_lsp' },
    { name = 'cmdline' },
    { name = 'nvim_lua' }
  })
})

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  })
})
cmp.setup.filetype('norg', {
  sources = cmp.config.sources({
    { name = 'neorg' },
  }, {
    { name = 'buffer' },
  })
})


require'cmp_git'.setup {
  remotes = { "upstream", "fork", "origin" },
  filetypes = { "gitcommit", "markdown" },
}
