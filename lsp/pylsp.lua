---@type vim.lsp.Config
return {
  settings = {
    pylsp = {
      plugins = {
        mypy = { enabled = true },
        isort = { enabled = true },
        pycodestyle = { enabled = false },
        pyflakes = { enabled = false },
      },
    },
  },
}
