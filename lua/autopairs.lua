require('nvim-autopairs').setup({
  disable_in_macro = true,
})

local ok, cmp = pcall(require, 'cmp')
if ok then
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
end
