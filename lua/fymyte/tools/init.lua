require'mason'.setup{
  ui = {
    check_outdated_packages_on_open = true,
    border = "rounded",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
  log_level = vim.g.log_level,
}

require'fymyte.tools.nvim-lua-lsp'
local lsp = require'fymyte.tools.lsp'
lsp.setup_diagnostics_mappings()
lsp.override_open_floating_preview { border = 'rounded' }
lsp.setup_servers(lsp.servers)

require'fymyte.tools.dap'
