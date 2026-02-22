local augroup = require('fymyte.utils').augroup
local autocmd = vim.api.nvim_create_autocmd
local autocmd_clr = vim.api.nvim_clear_autocmds

---@class fymyte.lsp.Config
---@field augroups {[integer]:integer} map of lsp client id to autocmd group
---@field capabilities lsp.ClientCapabilities resolved capabilities for neovim client
---@field on_attach elem_or_list<fun(client: vim.lsp.Client, bufnr: integer)> lsp on_attach callback
---@field on_exit? elem_or_list<fun(code: integer, signal: integer, cliend_id: integer)> lsp on_attach callback
---@field default_config vim.lsp.Config default lsp configuration, used for all LSP

---@type fymyte.lsp.Config
local lsp

---@brief Custom on_attach callback
---@param client vim.lsp.Client client
---@param bufnr integer
local function on_attach(client, bufnr)
  if not client.server_capabilities then
    return
  end

  if client.server_capabilities.semanticTokensProvider == true then
    vim.lsp.semantic_tokens.start(bufnr, client.id)
  end

  if client.server_capabilities.documentHighlightProvider then
    lsp.augroups[client.id] = augroup('document-hightlight-' .. client.name)
    autocmd_clr { buffer = bufnr, group = lsp.augroups[client.id] }
    autocmd({ 'CursorHold', 'CursorHoldI' }, {
      group = lsp.augroups[client.id],
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
    })
    autocmd('CursorMoved', { group = lsp.augroups[client.id], callback = vim.lsp.buf.clear_references, buffer = bufnr })
  end

  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable()
  end
end

-- Avoids error when trying to force close an LSP client
local function on_exit(_, _, client_id)
  local function clear()
    autocmd_clr { group = lsp.augroups[client_id] }
  end

  if vim.in_fast_event() then
    vim.schedule(clear)
  else
    clear()
  end
end

lsp = {
  augroups = {},
  default_config = {},
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  on_attach = on_attach,
  on_exit = on_exit,
}

--- @brief Default config for every lsp servers
--- Server specific configurations are done in lsp/<name>.lua
--- @type vim.lsp.Config
lsp.default_config = {
  on_attach = lsp.on_attach,
  on_exit = lsp.on_exit,
  capabilities = lsp.capabilities,
  root_marker = { '.git' },
}
vim.lsp.config('*', lsp.default_config)

vim.lsp.enable {
  'harper-ls',
  'emmylua_ls',
  'taplo',
  'yaml-ls',
  'jsonls',
  'nil_ls',
  'nixd',
  'gopls',
  'clangd',
  'ruff',
  'pylsp',
  'neocmakelsp',
  'bashls',
  'ltex_plus',
  'zls',
}

return lsp
