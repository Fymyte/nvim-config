local M = {}

---@brief Use provided config when lsp opens a window
---@param config table: Map defining the window configuration. (See `:h nvim_open_win`)
function M.override_open_floating_preview(config)
  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
    opts = vim.tbl_extend('force', opts, config)
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
  end
end

function M.setup_diagnostics_mappings()
  -- Global keymaps to navigate vim diagnostics
  local opts = { noremap = true, silent = true }
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
  -- vim.keymap.set('n', '<leader>e', require('lspsaga.diagnostic').show_line_diagnostics, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
end

---@brief Provide additional key mappings when a lsp server is attached
---@param client vim.lsp.client
local function custom_attach(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  -- vim.keymap.set('n', 'gh', require('lspsaga.finder').lsp_finder, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'ge', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  -- vim.keymap.set('n', 'K', require("lspsaga.hover").render_hover_doc, bufopts)
  -- vim.keymap.set('n', '<C-k>', require('lspsaga.signaturehelp').signature_help, bufopts)

  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)

  vim.keymap.set('n', 'gr', vim.lsp.buf.rename, bufopts)
  -- vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<cr>", bufopts)

  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  -- vim.keymap.set('v', '<leader>ca', vim.lsp.buf.range_code_action, bufopts)

  -- vim.keymap.set("n", "<leader>ca", require'lspsaga.codeaction'.code_action, bufopts)
  -- vim.keymap.set("v", "<leader>ca", function()
  --     vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
  --     require'lspsaga.codeaction'.range_code_action()
  -- end, bufopts)

  vim.keymap.set('n', '<space>f', function()
    -- Checks if null-ls is present and able to format the buffer, otherwise allow formatting with other lsp
    local clients = vim.lsp.get_active_clients { bufnr = vim.api.nvim_get_current_buf() }
    clients = vim.tbl_filter(function(client)
      return client.name == 'null-ls' and client.supports_method 'textDocument/formatting'
    end, clients)
    vim.lsp.buf.format {
      async = true,
      filter = function(formatting_client)
        return #clients <= 0 or formatting_client.name == 'null-ls'
      end,
    }
  end, bufopts)

  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
    vim.api.nvim_clear_autocmds { buffer = bufnr, group = 'lsp_document_highlight' }
    vim.api.nvim_create_autocmd('CursorHold', {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = 'lsp_document_highlight',
      desc = 'Document Highlight',
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = 'lsp_document_highlight',
      desc = 'Clear All the References',
    })
  end

  -- Show line diagnostic on cursor hold
  -- vim.cmd([[autocmd CursorHold <buffer> lua vim.diagnostic.open_float()]])lsp

  vim.notify(('lsp %s attached'):format(client.name), 'info', { title = 'LSP' })
end

local function get_client_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local has_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, 'cmd_nvim_lsp')
  if has_cmp_nvim_lsp then
    capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
  end
  return capabilities
end

require('lspconfig').util.default_config = vim.tbl_extend('force', require('lspconfig').util.default_config, {
  on_attach = custom_attach,
  capabilities = get_client_capabilities(),
})

require('mason-lspconfig').setup {
  automatic_installation = true,
}

local ltex_languages = {
  'auto',
  'ar',
  'ast-ES',
  'be-BY',
  'br-FR',
  'ca-ES',
  'ca-ES-valencia',
  'da-DK',
  'de',
  'de-AT',
  'de-CH',
  'de-DE',
  'de-DE-x-simple-language',
  'el-GR',
  'en',
  'en-AU',
  'en-CA',
  'en-GB',
  'en-NZ',
  'en-US',
  'en-ZA',
  'eo',
  'es',
  'es-AR',
  'fa',
  'fr',
  'ga-IE',
  'gl-ES',
  'it',
  'ja-JP',
  'km-KH',
  'nl',
  'nl-BE',
  'pl-PL',
  'pt',
  'pt-AO',
  'pt-BR',
  'pt-MZ',
  'pt-PT',
  'ro-RO',
  'ru-RU',
  'sk-SK',
  'sl-SI',
  'sv',
  'ta-IN',
  'tl-PH',
  'uk-UA',
  'zh-CN',
}

if require 'neodev' then
  require('neodev').setup {}
end

---@alias ServerConfig table|function|nil
---@alias ServerConfigs table<string,ServerConfig>
---@type ServerConfigs
M.servers = {
  ['rust_analyzer'] = function()
    local extension_path = vim.fn.stdpath 'data' .. '/mason/packages/codelldb/extension'
    local codelldb_path = extension_path .. '/adapter/codelldb'
    local liblldb_path = extension_path .. '/lldb/lib/liblldb.so'
    require('rust-tools').setup {
      -- tools = {
      --   on_initialized = function(health) vim.notify(('rust analyzer ready (%s)'):format(health.health))
      --   end,
      -- },
      dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path),
      },
    }
  end,
  ['clangd'] = function()
    require('clangd_extensions').setup {
      server = {
        on_attach = custom_attach,
        capabilities = get_client_capabilities(),
      },
      extensions = {
        memory_usage = { border = 'rounded' },
        symbol_info = { border = 'rounded' },
      },
    }
  end,
  ['sumneko_lua'] = {
    settings = {
      Lua = {
        diagnostics = { globals = { 'vim' } }, -- Get the language server to recognize the `vim` global
        telemetry = { enable = false },
        hint = { setType = true },
        IntelliSense = {
          traceLocalSet = true,
          traceReturn = true,
          traceBeSetted = true,
          traceFieldInject = true,
        },
      },
    },
  },
  ['eslint'] = nil,
  -- ['denols'] = {},
  ['tsserver'] = {},
  ['zls'] = {},
  ['vimls'] = nil,
  ['bashls'] = {},
  ['cmake'] = nil,
  -- ['pylsp'] = {
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
  --   },
  -- },
  ['taplo'] = {},
  ['pyright'] = {},
  ['ltex'] = function()
    local function setup_ltex(lang)
      local config = {
        on_attach = function(client, bufnr)
          custom_attach(client, bufnr)
          require('ltex_extra').setup {
            load_langs = { 'en-US', 'fr-FR' },
            -- init_check = true,
            path = vim.fn.stdpath 'config' .. '/spell/dictionaries',
          }
          vim.api.nvim_create_user_command('LtexSwitchLang', function(args)
            local splited_args = vim.split(args.args, ' ', { trimemtpy = true })
            -- local ltex_clients = vim.lsp.get_active_clients({bufnr=0, name="ltex"})
            -- for _, ltex_client in ipairs(ltex_clients) do
            --   vim.lsp.stop_client(ltex_client.id, false)
            -- end
            setup_ltex(splited_args[1])
          end, {
            nargs = 1,
            complete = function(ArgLead, _, _)
              return vim.tbl_filter(function(el)
                return el:find(ArgLead, 1, true)
              end, ltex_languages)
            end,
          })
        end,
        settings = {
          ['ltex'] = {
            configurationTarget = {
              dictionary = 'user',
              disabledRules = 'workspaceFolderExternalFile',
              hiddenFalsePositives = 'workspaceFolderExternalFile',
            },
            language = lang,
          },
        },
      }
      require('lspconfig')['ltex'].setup(config)
    end
    setup_ltex 'en-US'
  end,
}

require('null-ls').setup {
  sources = {
    require('null-ls').builtins.formatting.stylua,
    require('null-ls').builtins.formatting.clang_format,
    require('null-ls').builtins.diagnostics.eslint_d,
    require('null-ls').builtins.diagnostics.selene,
    require('null-ls').builtins.formatting.prettier,
    require('null-ls').builtins.formatting.shfmt,
    require('null-ls').builtins.code_actions.shellcheck,
  },
}

---@param servers ServerConfigs
M.setup_servers = function(servers)
  for server, config in pairs(servers) do
    if type(config) == 'boolean' then
      if config then
        require('lspconfig')[server].setup {}
      end
    elseif type(config) == 'function' then
      config()
    elseif type(config) == 'table' then
      require('lspconfig')[server].setup(config)
    end
  end
end

---Setup extra features
---@param extras table<string> extras  to enables
M.setup_extras = function(extras)
  -- local extra_autocmd = vim.api.nvim_create_augroup("lsp_extras", {})
  local builtin_extras = {
    ['highlight_symbol_under_cursor'] = function()
      vim.cmd [[
      autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      ]]
    end,
  }
  for _, extra in ipairs(extras) do
    if builtin_extras[extra] and type(builtin_extras[extra]) == 'function' then
      builtin_extras[extra]()
    end
  end
end

return M
