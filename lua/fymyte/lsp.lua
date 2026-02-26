local augroup = require('fymyte.utils').augroup
local autocmd = vim.api.nvim_create_autocmd
local autocmd_clr = vim.api.nvim_clear_autocmds
local pm = vim.lsp.protocol.Methods

---@brief Custom on_attach callback
---@param client vim.lsp.Client client
---@param bufnr integer
local function on_attach(client, bufnr)
  if client:supports_method(pm.textDocument_inlayHint, bufnr) then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end

  if client:supports_method(pm.textDocument_semanticTokens_full, bufnr) then
    vim.lsp.semantic_tokens.start(bufnr, client.id)
  end

  if client:supports_method(pm.textDocument_documentHighlight, bufnr) then
    local gid = augroup('document-highlight-' .. client.name)
    autocmd({ 'CursorHold', 'CursorHoldI' }, { group = gid, callback = vim.lsp.buf.document_highlight, buffer = bufnr })
    autocmd('CursorMoved', { group = gid, callback = vim.lsp.buf.clear_references, buffer = bufnr })
  end
end

---@brief Custom on_exit callback
--- Avoids error when trying to force close an LSP client
---@param client vim.lsp.Client client
local function on_exit(client)
  local function clear()
    vim.lsp.buf.clear_references()
    autocmd_clr { group = augroup('document-highlight-' .. client.name) }
  end

  if vim.in_fast_event() then
    vim.schedule(clear)
  else
    clear()
  end
end

autocmd('LspAttach', {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    on_attach(client, args.buf)
  end,
})

autocmd('LspDetach', {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    on_exit(client)
  end,
})

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
