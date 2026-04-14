vim.pack.add {
  { src = Utils.gh 'saghen/blink.cmp', version = vim.version.range('*') },
  Utils.gh 'rafamadriz/friendly-snippets',
  { src = Utils.gh 'L3MON4D3/LuaSnip', version = vim.version.range('2') },
}

require 'blink.cmp'.setup(
  {
    keymap = {
      ['<C-k>'] = { 'snippet_forward', 'fallback' },
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
  }
)
