local ok, kanagawa = pcall(require, 'kanagawa')
if not ok then
  return
end

local colors = {
  sumiInk1 = '#212121',
  sumiInk0 = '#2A2A2A',
  sumiInk2 = '#353535',
  sumiInk3 = '#414141',
  sumiInk4 = '#5F5F5F',

  waveBlue1 = '#2F2F2F',
  waveBlue2 = '#393939',
}

kanagawa.setup {
  undercurl = true, -- enable undercurls
  commentStyle = { italic = true },
  functionStyle = {},
  keywordStyle = { italic = true },
  statementStyle = { bold = true },
  typeStyle = {},
  variablebuiltinStyle = { italic = true },
  specialReturn = true, -- special highlight for the return keyword
  specialException = true, -- special highlight for exception handling keywords
  transparent = false, -- use background colors defined above
  dimIncative = false,
  globalStatus = false,
  colors = colors,
  overrides = {
    -- TSVariable = { fg = "#ECD2A2" }
    TSVariable = { link = 'TSField' },
  },
}

kanagawa.load()
-- vim.api.nvim_set_hl(0, 'FloatBorder', { link="Normal" })
vim.cmd [[highlight! link FloatBorder Normal]]
