---@type LazyPluginSpec
return {
  'saghen/blink.cmp',
  enabled = true,
  dependencies = {
    'rafamadriz/friendly-snippets',
    { 'L3MON4D3/LuaSnip', version = 'v2.*' },
  },
  version = '*',
  event = 'VeryLazy',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      ['<C-k>'] = { 'show_documentation', 'hide_documentation', 'snippet_forward', 'fallback' },
      ['<C-j>'] = { 'snippet_backward', 'fallback' },
    },

    snippets = { preset = 'luasnip' },

    completion = {
      list = {
        max_items = 50,
        selection = { preselect = true, auto_insert = false },
      },
      documentation = { auto_show = true, auto_show_delay_ms = 500 },
      accept = { auto_brackets = { enabled = false } },
    },

    signature = { enabled = true },

    cmdline = {
      keymap = {
        ['<C-n>'] = { 'show_and_insert', 'select_next' },
      },
    },
  },
}
