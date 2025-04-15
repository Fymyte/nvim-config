---@type LazyPluginSpec
return {
  'echasnovski/mini.ai',
  config = function(_, _)
    local spec_treesitter = require('mini.ai').gen_spec.treesitter
    require('mini.ai').setup {}
  end,
  -- A block of comment
  -- consecutive
  --[[
  also a comment
  --]]
}
