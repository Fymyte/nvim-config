--# selene: allow(unused_variable)
--- @diagnostic disable:unused-local

local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require 'luasnip.util.events'
local ai = require 'luasnip.nodes.absolute_indexer'
local extras = require 'luasnip.extras'
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local conds = require 'luasnip.extras.expand_conditions'
local postfix = require('luasnip.extras.postfix').postfix
local types = require 'luasnip.util.types'
local parse = require('luasnip.util.parser').parse_snippet
local ms = ls.multi_snippet

ls.add_snippets('all', {
  ls.parser.parse_snippet('expand', '--this is what will be expanded'),
})

ls.add_snippets('lua', {
  s(
    'req',
    fmt([[local {} = require("{}")]], {
      f(function(import)
        local parts = vim.split(import[1][1], '.', { plain = true })
        return parts[#parts] or ''
      end, { 1 }),
      i(1),
    })
  ),
})

ls.add_snippets('rust', {
  s(
    'modtest',
    fmt(
      [[
      #[cfg(test)]
      mod test {{
      {}

          {}
      }}
    ]],
      {
        c(1, { t '    use super::*;', t '' }),
        i(0),
      }
    )
  ),
})