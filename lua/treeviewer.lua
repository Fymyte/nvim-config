local g = vim.g

g.nvim_tree_icons = {
  git = {
    unstaged = "",
    staged = "✚",
    unmerged = "",
    renamed = "➜",
    untracked = "★",
    deleted = "✖",
    ignored = "◌",
    modified = '✹',
  },
}
g.nvim_tree_group_empty = 1

require('nvim-tree').setup {
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
}
