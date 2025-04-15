---@type vim.lsp.Config
return {
  cmd = { 'pylsp' },
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

  settings = {
    pylsp = {
      plugins = {
        mypy = { enabled = true },
        pycodestyle = { enabled = false },
        pyflakes = { enabled = false },
      },
    },
  },
}
