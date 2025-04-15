---@type vim.lsp.Config
return {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = {
    '.git',
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'ruff.toml',
    '.ruff.toml',
  },
}
