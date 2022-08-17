local M = {}


---@brief Use provided config when lsp opens a window
---@param config table: Map defining the window configuration. (See `:h nvim_open_win`)
function M.override_open_floating_preview(config)
  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
    opts = vim.tbl_extend("force", opts, config)
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
  end
end

function M.setup_diagnostics_mappings()
  -- Global keymaps to navigate vim diagnostics
  local opts = { noremap = true, silent = true }
  -- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '<leader>e', require("lspsaga.diagnostic").show_line_diagnostics, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
end

---@brief Provide additional key mappings when a lsp server is attached
---@param client vim.lsp.client
local function custom_attach(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "gh", require("lspsaga.finder").lsp_finder, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'ge', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  -- vim.keymap.set('n', 'K', require("lspsaga.hover").render_hover_doc, bufopts)
  vim.keymap.set('n', '<C-k>', require("lspsaga.signaturehelp").signature_help, bufopts)

  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)

  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "gr", require("lspsaga.rename").lsp_rename, bufopts)

  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('v', '<leader>ca', vim.lsp.buf.range_code_action, bufopts)

  -- vim.keymap.set("n", "<leader>ca", require'lspsaga.codeaction'.code_action, bufopts)
  -- vim.keymap.set("v", "<leader>ca", function()
  --     vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
  --     require'lspsaga.codeaction'.range_code_action()
  -- end, bufopts)

  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format{async=true} end, bufopts)

  -- Show line diagnostic on cursor hold
  -- vim.cmd([[autocmd CursorHold <buffer> lua vim.diagnostic.open_float()]])lsp

  vim.notify(('lsp %s attached'):format(client.name), "info", {title="LSP"})
end

local function get_client_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local has_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, 'cmd_nvim_lsp')
  if has_cmp_nvim_lsp then
    capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
  end
  return capabilities
end



require'lspconfig'.util.default_config = vim.tbl_extend(
  'force',
  require'lspconfig'.util.default_config,
  {
    on_attach = custom_attach,
    capabilities = get_client_capabilities(),
  }
)

require'mason-lspconfig'.setup {
  automatic_installation = true,
}

---@alias ServerConfig table|function|nil
---@alias ServerConfigs table<string,ServerConfig>
---@type ServerConfigs
M.servers = {
  ['rust_analyzer'] = function ()
    local extension_path = vim.fn.stdpath'data' .. '/mason/packages/codelldb/extension'
    local codelldb_path = extension_path .. '/adapter/codelldb'
    local liblldb_path = extension_path .. '/lldb/lib/liblldb.so'
    require'rust-tools'.setup {
      on_initialized = function(health) vim.notify(("rust analyzer ready (%s)"):format(health)) end,
      dap = {
        adapter = require'rust-tools.dap'.get_codelldb_adapter(codelldb_path, liblldb_path)
      }
    }
  end,
  ['clangd'] = function ()
    require'clangd_extensions'.setup {
      server = {
        on_attach = custom_attach,
        capabilities = get_client_capabilities(),
      },
      extensions = {
        memory_usage = { border = "rounded" },
        symbol_info = { border = "rounded" },
      }
    }
  end,
  ['sumneko_lua'] = require'lua-dev'.setup{
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" }, }, -- Get the language server to recognize the `vim` global
        telemetry = { enable = false },
        hint = { setType = true },
        IntelliSense = {
          traceLocalSet = true,
          traceReturn = true,
          traceBeSetted = true,
          traceFieldInject = true,
        }
      }
    }
  },
  ['zls']= {},
  ['vimls'] = nil,
  ['bashls'] = nil,
  ['cmake'] = nil,
  ['pylsp'] = {
    settings = {
      pylsp = {
        configurationSources = { 'pylsp_flake8', 'pylsp_mypy' },
        plugins = {
          yapf = { enabled = true },
          autopep8 = { enabled = false },
          pylint = { enabled = true },
          jedi_completion = { fuzzy = true },
          pyls_isort = { enabled = true },
          pyls_flake8 = { enabled = true },
          pylsp_mypy = { enabled = true, strict = true },
          pylsp_rope = { enabled = true },
        },
      },
    }
  },
  ["taplo"] = {},
  pyright = nil,
  ["ltex"] = {
    on_attach = function(client, bufnr)
      custom_attach(client, bufnr)
      require'ltex_extra'.setup {
        load_langs = { 'en-US', 'fr-FR' },
        -- init_check = true,
        path = vim.fn.stdpath('config') .. '/spell/dictionaries',
      }
    end,
    settings = {
      ["ltex"] = {
        configurationTarget = {
          dictionary = "user",
          disabledRules = "workspaceFolderExternalFile",
          hiddenFalsePositives = "workspaceFolderExternalFile"
        },
      },
    }
  },
}

require'null-ls'.setup({
  sources = {
    require("null-ls").builtins.formatting.stylua,
    require'null-ls'.builtins.formatting.clang_format,
    require("null-ls").builtins.diagnostics.eslint_d,
    require("null-ls").builtins.diagnostics.selene,
  },
})

---@param servers ServerConfigs
M.setup_servers = function (servers)
  for server, config in pairs(servers) do
    if type(config) == "boolean" then
      if config then require'lspconfig'[server].setup{} end
    elseif type(config) == "function" then
      config()
    elseif type(config) == "table" then
      require'lspconfig'[server].setup(config)
    end
  end
end

return M
