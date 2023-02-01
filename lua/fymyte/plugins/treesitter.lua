-- Disable tree-sitter parser for large files
local function disable_for_large_files(lang, buf)
  local max_filesize = 100 * 1024 -- 100 KB
  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
  if ok and stats and stats.size > max_filesize then
    return true
  end
end

local ensure_installed = {
  'c',
  'cpp',
  'rust',
  'css',
  'vim',
  'lua',
  'query',
  'regex',
  'bash',
  'markdown',
  'markdown_inline',
}

return {
  'nvim-treesitter/nvim-treesitter',
  version = false,
  build = function()
    pcall(require('nvim-treesitter.install').update { with_sync = true })
  end,
  event = 'BufReadPost',
  opts = {
    auto_install = true,
    ensure_installed = ensure_installed,
    indent = { enable = true },

    -- Highlights
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
      disable = disable_for_large_files,
    },

    -- Playground
    playground = {
      enable = true,
      disable = disable_for_large_files,
    },
    query_linter = { enable = true },
  },
  config = function(_, opts)
    require'nvim-treesitter.configs'.setup(opts)
  end,

  dependencies = { 'nvim-treesitter/playground' }
}
