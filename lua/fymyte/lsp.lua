-- Use provided config when lsp opens a window
-- @param config table: Map defining the window configuration. (See `:h nvim_open_win`)
local function lsp_override_open_floating_preview_opts(config)
  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
    opts = vim.tbl_extend("force", opts, config)
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
  end
end

vim.lsp.set_log_level(vim.g.log_level)

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

  vim.keymap.set("n", "gh", require("lspsaga.finder").lsp_finder, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'K', require("lspsaga.hover").render_hover_doc, bufopts)
  vim.keymap.set('n', '<C-k>', require("lspsaga.signaturehelp").signature_help, bufopts)

  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)

  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "gr", require("lspsaga.rename").lsp_rename, bufopts)

  -- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  -- vim.keymap.set('v', '<leader>ca', vim.lsp.buf.range_code_action, bufopts)

  local action = 
  vim.keymap.set("n", "<leader>ca", require'lspsaga.codeaction'.code_action, bufopts)
  vim.keymap.set("v", "<leader>ca", function()
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
      require'lspsaga.codeaction'.range_code_action()
  end, bufopts)

  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format{async=true} end, bufopts)

  -- Show line diagnostic on cursor hold
  -- vim.cmd([[autocmd CursorHold <buffer> lua vim.diagnostic.open_float()]])

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
  -- Called from rusttools and clangd_extensions
  -- ["rust_analyzer"] = {},
  -- ["clangd"] = {},
  ["sumneko_lua"] = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT", -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          path = runtime_path, -- Setup your lua path
        },
        diagnostics = { globals = { "vim" }, }, -- Get the language server to recognize the `vim` global
        workspace = { library = vim.api.nvim_get_runtime_file("", true) }, -- Make the server aware of Neovim runtime files
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
  zls = {},
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

-- lsp_override_open_floating_preview_opts { border = 'rounded' }
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

local has_clangd_extension, clangd_extensions = pcall(require, 'clangd_extensions')
if has_clangd_extension then
  clangd_extensions.setup {
    server = {
      on_attach = custom_attach,
      capabilities = get_client_capabilities(),
    },
    extensions = {
      ast = {
            role_icons = {
                type = "",
                declaration = "",
                expression = "",
                specifier = "",
                statement = "",
                ["template argument"] = "",
            },

            kind_icons = {
                Compound = "",
                Recovery = "",
                TranslationUnit = "",
                PackExpansion = "",
                TemplateTypeParm = "",
                TemplateTemplateParm = "",
                TemplateParamObject = "",
            },

            highlights = {
                detail = "Comment",
            },
        },
      memory_usage = { border = "rounded" },
      symbol_info = { border = "rounded" },
    }
  }
end
