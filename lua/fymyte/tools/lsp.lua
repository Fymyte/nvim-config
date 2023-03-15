local augroup = require('fymyte.utils').augroup
local autocmd = require('fymyte.utils').autocmd
local autocmd_clr = vim.api.nvim_clear_autocmds

local autocmd_simple = function(args)
  local event = args[1]
  local group = args[2]
  local callback = args[3]

  autocmd(event, {
    group = group,
    buffer = args[4],
    callback = function()
      callback()
    end,
    once = args.once,
    desc = args.desc,
  })
end

local augroup_references = augroup 'lsp-document-highlight'

local M = {}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

---@brief Use provided config when lsp opens a window
---@param config table: Map defining the window configuration. (See `:h nvim_open_win`)
function M.override_open_floating_preview(config)
  ---@diagnostic disable-next-line:duplicate-set-field
  vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
    opts = vim.tbl_extend('force', opts, config)
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
  end
end

---Get the list of clients able to format the buffer.
---If null-ls is present, prefer using null-ls to format.
---Otherwise use the first available client able to format
---@param formatting_client vim.lsp.client
---@return boolean
local function formating_client_filter(formatting_client)
  local clients = vim.tbl_filter(function(client)
    return client.name == 'null-ls' and client.supports_method 'textDocument/formatting'
  end, vim.lsp.get_active_clients { bufnr = vim.api.nvim_get_current_buf() })
  return #clients <= 0 or formatting_client.name == 'null-ls'
end

---@brief Provide additional key mappings when a lsp server is attached
---@param client vim.lsp.client
---@param bufnr number
local function custom_attach(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  local buf_nmap = function(lhs, rhs, desc)
    vim.keymap.set('n', lhs, rhs, vim.tbl_extend('force', bufopts, { desc = desc }))
  end
  local buf_map = function(lhs, rhs, modes, desc)
    vim.keymap.set(modes, lhs, rhs, vim.tbl_extend('force', bufopts, { desc = desc }))
  end

  if pcall(require, 'telescope') then
    buf_nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition (include Declaration)')
    buf_nmap('gt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype definition')
    buf_nmap('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    buf_nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eference')
  else
    buf_nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    buf_nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    buf_nmap('gt', vim.lsp.buf.type_definition, '[G]oto [T]ype definition')
    buf_nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    buf_nmap('gr', vim.lsp.buf.references, '[G]oto [R]eference')
  end

  buf_nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd folder')
  buf_nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove folder')
  buf_nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist folders')

  buf_nmap('K', vim.lsp.buf.hover, 'LSP hover action')
  buf_nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  buf_nmap('<leader>cr', vim.lsp.buf.rename, '[C]ode [R]ename')

  buf_map('<leader>f', function()
    vim.lsp.buf.format { async = true, filter = formating_client_filter }
  end, { 'n', 'v' }, '[F]ormat')

  local serv_caps = client.server_capabilities

  if serv_caps.documentHighlightProvider then
    autocmd_clr { buffer = bufnr, group = augroup_references }
    autocmd_simple { 'CursorHold', augroup_references, vim.lsp.buf.document_highlight, bufnr }
    autocmd_simple { 'CursorMoved', augroup_references, vim.lsp.buf.clear_references, bufnr }
  end

  vim.notify(('%s attached'):format(client.name), vim.log.levels.INFO, { title = 'LSP' })
end

local updated_capabilites = vim.tbl_deep_extend(
  'force',
  vim.lsp.protocol.make_client_capabilities(),
  require('cmp_nvim_lsp').default_capabilities()
)

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

---@alias ServerConfig table|function|nil
---@alias ServerConfigs table<string,ServerConfig>
---@type ServerConfigs
M.servers = {
  ['rust_analyzer'] = function()
    local rust_analyzer_cmd = { 'rustup', 'run', 'nightly', 'rust-analyzer' }
    local extension_path = vim.fn.stdpath 'data' .. '/mason/packages/codelldb/extension'
    local codelldb_path = extension_path .. '/adapter/codelldb'
    local liblldb_path = extension_path .. '/lldb/lib/liblldb.so'

    require('rust-tools').setup {
      server = {
        -- `on_attach` and `capabilities` are set using default values
        cmd = rust_analyzer_cmd,
        settings = {
          ['rust-analyzer'] = {
            check = { command = 'clippy' },
            procMacro = { enabled = true },
          },
        },
      },
      dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path),
      },
    }
  end,
  ['clangd'] = function()
    require('clangd_extensions').setup {
      server = {
        on_attach = custom_attach,
        capabilities = updated_capabilites,
      },
      extensions = {
        memory_usage = { border = 'rounded' },
        symbol_info = { border = 'rounded' },
      },
    }
  end,
  ['lua_ls'] = {
    settings = {
      Lua = {
        diagnostics = { globals = { 'vim' } }, -- Get the language server to recognize the `vim` global
        completion = { callSnippet = 'Replace' },
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

---@param servers ServerConfigs
M.setup_servers = function(servers)
  require('lspconfig').util.default_config = vim.tbl_deep_extend('force', require('lspconfig').util.default_config, {
    on_attach = custom_attach,
    capabilities = updated_capabilites,
  })

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

return M
