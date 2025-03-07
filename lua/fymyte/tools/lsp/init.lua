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

  if client.server_capabilities.documentHighlightProvider then
    autocmd_clr { buffer = bufnr, group = augroup_references }
    autocmd_simple { 'CursorHold', augroup_references, vim.lsp.buf.document_highlight, bufnr }
    autocmd_simple { 'CursorMoved', augroup_references, vim.lsp.buf.clear_references, bufnr }
  end

  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable()
  end

  vim.notify(('%s attached'):format(client.name), vim.log.levels.INFO, { title = 'LSP' })
end

M.attach = custom_attach

local updated_capabilites = vim.tbl_deep_extend(
  'force',
  vim.lsp.protocol.make_client_capabilities(),
  require('cmp_nvim_lsp').default_capabilities()
)

---
---@alias ServerConfig lspconfig.Config|fun(default_config: lspconfig.Config)|nil

---@type table<string, ServerConfig>
local servers = {
  ['asm_lsp'] = {},
  ['clangd'] = function()
    require('clangd_extensions').setup {
      memory_usage = { border = 'rounded' },
      symbol_info = { border = 'rounded' },
    }
    require('lspconfig')['clangd'].setup {
      cmd = {
        'clangd',
        '--background-index',
        '--clang-tidy',
      },
      on_attach = custom_attach,
    }
  end,
  ['lua_ls'] = {
    settings = {
      Lua = {
        diagnostics = { globals = { 'vim' } }, -- Get the language server to recognize the `vim` global
        format = { enable = false }, -- Use stylua for that
        completion = { callSnippet = 'Replace' },
        telemetry = { enable = false },
        hint = { enable = true, setType = true },
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
  ['ts_ls'] = {},
  ['zls'] = {},
  ['vimls'] = nil,
  ['bashls'] = {},
  ['pylsp'] = {
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = { enabled = false },
          pyflakes = { enabled = false },
        },
      },
    },
  },
  ['nil_ls'] = {},
  ['taplo'] = {},
  ['yamlls'] = {
    settings = {
      yaml = {
        schemas = {
          ['https://github.com/devicetree-org/dt-schema/blob/main/dtschema/'] = 'http://devicetree.org/',
          ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = '/*compose.y*ml'
        },
      },
    },
  },
}

M.setup = function()
  local me = vim.fs.dirname(debug.getinfo(1, 'S').source:sub(2))
  local server_path = vim.fs.normalize(me .. '/' .. 'servers')
  local server_files = require('plenary.scandir').scan_dir(server_path, { depth = 1 })

  local default_config = vim.tbl_deep_extend('force', require('lspconfig').util.default_config, {
    on_attach = custom_attach,
    capabilities = updated_capabilites,
  })
  require('lspconfig').util.default_config = default_config

  for _, server in ipairs(server_files) do
    server = vim.fn.fnamemodify(server, ':p')
    local server_name = vim.fn.fnamemodify(server, ':t:r')
    if server_name ~= nil then
      local server_config = dofile(server)
      if type(server_config) == 'function' then
        server_config = server_config(default_config)
      end
      servers[server_name] = server_config
    end
  end

  for server, config in pairs(servers) do
    if type(config) == 'boolean' then
      if config then
        require('lspconfig')[server].setup {}
      end
    elseif type(config) == 'function' then
      config(require('lspconfig').util.default_config)
    elseif type(config) == 'table' then
      require('lspconfig')[server].setup(config)
    end
  end
end

return M
