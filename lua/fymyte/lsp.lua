local lsp = vim.lsp
local api = vim.api
local g = vim.g

local utils = require('fymyte.utils')

-- Use provided config when lsp opens a window
-- @param type Map defining the window configuration. (See `:h nvim_open_win`)
local function lsp_override_open_floating_preview_opts(config)
  local orig_util_open_floating_preview = lsp.util.open_floating_preview
  lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
    opts = vim.tbl_extend("force", opts, config)
    opts.border = border or opts.border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
  end
end

lsp.set_log_level(g.log_level)


--- Goto definition in split window, see
--- [lspconfig wiki](https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#go-to-definition-in-a-split-window)

local function setup_global_mappings()
  -- Global keymaps to navigate vim diagnostics
  local opts = { noremap = true, silent = true }
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
end

--- Provide additional key mappings when a lsp server is attached
local function custom_attach(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)

  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('v', '<leader>ca', vim.lsp.buf.range_code_action, bufopts)

  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)

  -- Show line diagnostic on cursor hold
  -- vim.cmd([[autocmd CursorHold <buffer> lua vim.diagnostic.open_float()]])

  vim.notify(('lsp %s attached'):format(client.name))
end

local function get_client_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local has_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, 'cmd_nvim_lsp')
  if has_cmp_nvim_lsp then
    capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
  end
  return capabilities
end

-- Setup lspconfig and lsp_installer
local has_lspconfig, lspconfig = pcall(require, 'lspconfig')
if not has_lspconfig then
  return
end
local has_lsp_installer, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not has_lsp_installer then
  return
end


lspconfig.util.default_config = vim.tbl_extend(
  'force',
  lspconfig.util.default_config,
  {
    on_attach = custom_attach,
    capabilities = get_client_capabilities(),
  }
)

lsp_installer.setup {
  automatic_installation = true,
  ui = {
    check_outdated_servers_on_open = true,
    border = "rounded",
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗",
    },
  },
  log_level = vim.log.levels.INFO,
}

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local servers = {
  ["rust_analyzer"] = {},
  ["clangd"] = {},
  ["sumneko_lua"] = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT", -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          path = runtime_path, -- Setup your lua path
        },
        diagnostics = { globals = { "vim" }, }, -- Get the language server to recognize the `vim` global
        workspace = { library = api.nvim_get_runtime_file("", true) }, -- Make the server aware of Neovim runtime files
        telemetry = { enable = false },
        hint = { setType = true },
      }
    }
  },
  -- ["vimls"] = {},
  -- ["bashls"] = {},
  ["cmake"] = {},
  -- ["pylsp"] = {
  --   settings = {
  --     pylsp = {
  --       configurationSources = { 'pylsp_flake8', 'pylsp_mypy' },
  --       plugins = {
  --         yapf = { enabled = true },
  --         autopep8 = { enabled = false },
  --         pylint = { enabled = true },
  --         jedi_completion = { fuzzy = true },
  --         pyls_isort = { enabled = true },
  --         pyls_flake8 = { enabled = true },
  --         pylsp_mypy = { enabled = true, strict = true },
  --         pylsp_rope = { enabled = true },
  --       },
  --     },
  --   }
  -- },
  -- ["taplo"] = {},
}

--   vim.cmd([[do User LspAttachBuffers]])
--   utils.log('info', ('Language server %q is ready'):format(server.name))

lsp_override_open_floating_preview_opts { border = 'rounded' }
setup_global_mappings()

for server, config in pairs(servers) do
  lspconfig[server].setup(config)
end

-- setup rust-tools
local has_rust_tools, rust_tools = pcall(require, 'rust-tools')
if has_rust_tools then
  rust_tools.setup {
    on_initialized = function(health)
      vim.notify(("rust analyzer ready (%s)"):format(health))
    end
  }
end
