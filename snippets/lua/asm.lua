--# selene: allow(unused_variable)
--- @diagnostic disable:unused-local

local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta

return {
  s(
    'macro',
    fmt(
      [[
    .macro {}
    	{}
    .endm]],
      { i(1), i(0) }
    )
  ),
}
