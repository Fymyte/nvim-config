local utils = require('utils')

local telescope = require('telescope')

telescope.setup{
  defaults = {
    theme = {
      border = true,
      borderchars = {
        prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
        results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
        preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      },
    },
  },
}

telescope.load_extension('notify')
telescope.load_extension('fzf')

utils.map({'n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<CR>]]})
utils.map({'n', '<leader>fl', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]]})
