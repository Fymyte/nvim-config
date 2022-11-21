local ok, telescope = pcall(require, 'telescope')
if not ok then
  return
end

local utils = require('fymyte.utils')

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
  pickers = {
    current_buffer_fuzzy_find = { theme = 'dropdown' },
    buffers = { theme = 'dropdown' },
    registers = { theme = 'dropdown' },
  },
  extensions = {
    file_browser = {
      theme = 'dropdown',
    },
    project = {
      base_dirs = {
        '~/.config/nvim',
      },
      theme = 'dropdown'
    },
    ['ui-select'] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    }
  }
}

telescope.load_extension'notify'
telescope.load_extension'fzf'
telescope.load_extension'file_browser'
telescope.load_extension'dict'
telescope.load_extension'project'
telescope.load_extension'ui-select'
telescope.load_extension'packer'
telescope.load_extension'todo-comments'
telescope.load_extension'live_grep_args'

local opts = { silent = true, noremap = true }

vim.keymap.set('n', '<leader>ff', require'telescope.builtin'.find_files, opts)
-- vim.keymap.set('n', '<leader>fl', require'telescope.builtin'.live_grep, opts)
vim.keymap.set('n', '<leader>fh', require'telescope.builtin'.help_tags, opts)
vim.keymap.set('n', '<leader>fy', require'telescope.builtin'.registers, opts)
vim.keymap.set('n', '<leader>fbb', require'telescope.builtin'.buffers, opts)
vim.keymap.set('n', '<leader>fc', require'telescope.builtin'.grep_string, opts)
vim.keymap.set('n', '<leader>fb', require'telescope'.extensions.file_browser.file_browser, opts)
vim.keymap.set('n', '<leader>fs', require'telescope'.extensions.dict.synonyms, opts)
vim.keymap.set('n', '<leader>fp', require'telescope'.extensions.project.project, opts)
vim.keymap.set('n', '<leader>fl', require'telescope'.extensions.live_grep_args.live_grep_args, opts)
vim.keymap.set('n', '<leader>ft', '<cmd>Telescope<cr>', opts)

