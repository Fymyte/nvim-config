vim.diagnostic.config {
  virtual_text = { prefix = '●', source = 'if_many' },
  signs = true,
  underline = { severity = vim.diagnostic.severity.ERROR },
  update_in_insert = true,
  severity_sort = false,
  float = { focusable = false },
}
