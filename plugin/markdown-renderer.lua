vim.pack.add {
  Utils.gh 'MeanderingProgrammer/render-markdown.nvim',
  Utils.gh 'nvim-tree/nvim-web-devicons',
}

require('render-markdown').setup {
  completions = { lsp = { enabled = true } },
  sign = { enabled = false },
  quote = { repeat_linebreak = true },
}
