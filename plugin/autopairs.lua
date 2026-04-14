vim.pack.add { Utils.gh 'windwp/nvim-autopairs' }

require('nvim-autopairs').setup {
  disable_in_macro = false,
  check_ts = true,
}
