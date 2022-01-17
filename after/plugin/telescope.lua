local ok, telescope = pcall(require, 'telescope')
if not ok then
  return
end

local utils = require('user.utils')

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
  extensions = {
    file_browser = {
      theme = 'ivy',
    }
  }
}

telescope.load_extension('notify')
telescope.load_extension('fzf')
telescope.load_extension('file_browser')
telescope.load_extension('dict')

utils.map({'n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<CR>]]})
utils.map({'n', '<leader>fl', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]]})
utils.map({'n', '<leader>fh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]]})
utils.map({'n', '<leader>fb', [[<cmd>lua require('telescope').extensions.file_browser.file_browser()<CR>]]})
utils.map({'n', '<leader>fs', [[<cmd>lua require('telescope').extensions.dict.synonyms()<CR>]]})
