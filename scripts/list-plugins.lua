---@type LazySpec
local plugins = require('lazy').plugins()

for _, plugin in ipairs(plugins) do
  print(string.format('- [%s](%s)', plugin.name, plugin.url))
end
