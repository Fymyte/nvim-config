local has_luasnip, ls = pcall(require, 'luasnip')
if not has_luasnip then
  return
end

local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require"luasnip.util.events"
local ai = require"luasnip.nodes.absolute_indexer"
local fmt = require"luasnip.extras.fmt".fmt
local m = require"luasnip.extras".m
local lambda = require"luasnip.extras".l
local postfix = require"luasnip.extras.postfix".postfix
local types = require"luasnip.util.types"
local rep = require"luasnip.extras".rep


ls.config.set_config {
  history = true,
  update_events = 'TextChanged,TextChangedI',
  delete_check_events = 'InsertLeave',
  enable_autosnippets = true,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = {{ "<-", "Error" }}
      }
    }
  }
}



ls.add_snippets("all", {
})

local opts = { silent = true, noremap = true }
vim.keymap.set({"i", "s"}, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, opts)
vim.keymap.set({"i", "s"}, "<c-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, opts)
vim.keymap.set({"i", "s"}, "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, opts)

vim.keymap.set("n", "<leader><leader>s", "<cmd>luafile ~/.config/nvim/after/plugin/luasnip.lua<CR>")
