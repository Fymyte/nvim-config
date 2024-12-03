vim.diagnostic.config {
  virtual_text = {
    prefix = '●',
    border = 'rounded',
  },
  signs = true,
  underline = { severity = vim.diagnostic.severity.ERROR },
  update_in_insert = true,
  severity_sort = false,
  float = { focusable = false },
}
