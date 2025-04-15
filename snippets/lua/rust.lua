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

local function get_test_result(position)
  return d(position, function()
    local nodes = {}
    table.insert(nodes, t ' ')

    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for _, line in ipairs(lines) do
      if line:match 'anyhow::{?.*Result.*}?' then
        table.insert(nodes, t ' -> Result<()>')
        break
      end
    end
    return sn(nil, c(1, nodes))
  end, {})
end

return {
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
  s(
    'test',
    fmt(
      [[
            #[test]
            fn {}(){}{{
                {}
            }}
    ]],
      {
        i(1, 'testname'),
        get_test_result(2),
        i(0),
      }
    )
  ),
}
