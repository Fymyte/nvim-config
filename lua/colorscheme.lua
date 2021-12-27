local colors = {
  sumiInk1 = "#212121",
  sumiInk0 = "#2A2A2A",
  sumiInk2 = "#353535",
  sumiInk3 = "#414141",
  sumiInk4 = "#5F5F5F",

  waveBlue1 = "#2F2F2F",
  waveBlue2 = "#393939",
}

require('kanagawa').setup({
    undercurl = true,           -- enable undercurls
    commentStyle = "italic",
    functionStyle = "NONE",
    keywordStyle = "italic",
    statementStyle = "bold",
    typeStyle = "NONE",
    variablebuiltinStyle = "italic",
    specialReturn = true,       -- special highlight for the return keyword
    specialException = true,    -- special highlight for exception handling keywords
    transparent = false,        -- do not set background color
    colors = colors,
    overrides = {},
})


vim.cmd( [[colorscheme kanagawa]] )
