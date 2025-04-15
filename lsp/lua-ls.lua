---@type vim.lsp.Config
return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },

  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },

  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = { 'lua/?.lua', 'lua/?/init.lua', 'lua/vim/?.lua', 'lua/vim/?/init.lua' },
        pathStrict = true,
      },
      workspace = {
        checkThirdParty = false,
        library = {
          -- Load vim runtime files
          vim.env.VIMRUNTIME,
          -- And all plugin's runtime paths as well
          ---@diagnostic disable-next-line: undefined-field
          unpack(vim.fn.split(vim.opt.rtp._value, ',')),
        },
      },
      format = { enable = true },
      completion = { callSnippet = 'Replace' },
      hint = { enable = true, setType = true },
      IntelliSense = {
        traceLocalSet = true,
        traceReturn = true,
        traceBeSetted = true,
        traceFieldInject = true,
      },
    },
  },
}
