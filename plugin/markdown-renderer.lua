vim.pack.add {
  Utils.gh 'MeanderingProgrammer/render-markdown.nvim',
  Utils.gh 'nvim-tree/nvim-web-devicons',
}

require('render-markdown').setup {
  completions = { lsp = { enabled = true } },
  sign = { enabled = false },
  quote = { repeat_linebreak = true },
  file_types = { 'markdown', 'Avante', 'copilot-chat', 'cc-output' },
  -- Keep the line under the cursor rendered, so the chat output does not jump
  overrides = { filetype = { ['cc-output'] = { anti_conceal = { enabled = false } } } }
}
