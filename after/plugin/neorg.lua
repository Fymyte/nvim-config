local has_neorg, neog = pcall(require, 'neorg')
if not has_neorg then
  return
end

neorg.setup {
  -- Tell Neorg what modules to load
  load = {
    ["core.defaults"] = {}, -- Load all the default modules
    ["core.norg.concealer"] = {
      config = {
        markup_preset = "dimmed",
      }
    }, -- Allows for use of icons
    ["core.norg.qol.toc"] = {},
    ["core.gtd.base"] = {
      config = {
        workspace = "gtd",
      }
    },
    ["core.norg.dirman"] = { -- Manage your directories with Neorg
      config = {
        workspaces = {
          notes = "~/Documents/notes/",
          gtd = "~/Documents/notes/gtd",
        }
      }
    },
    ["core.norg.completion"] = {
      config = {
        engine = "nvim-cmp" -- We current support nvim-compe and nvim-cmp only
      }
    },
    ["core.presenter"] = {},
    ["core.integrations.telescope"] = {},
  },
}

