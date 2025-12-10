return {
  'obsidian-nvim/obsidian.nvim',
  version = '*',
  ---@module "obsidian"
  ---@type obsidian.config
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = 'notes',
        path = '~/notes',
      },
      {
        name = 'notes',
        path = '~/Nextcloud/notes',
      },
      {
        name = 'no-vault',
        path = function()
          -- alternatively use the CWD:
          -- return assert(vim.fn.getcwd())
          return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
        end,
        overrides = {
          notes_subdir = vim.NIL, -- have to use 'vim.NIL' instead of 'nil'
          new_notes_location = 'current_dir',
          templates = {
            folder = vim.NIL,
          },
          frontmatter = { enabled = false },
        },
      },
    },
  },
}
