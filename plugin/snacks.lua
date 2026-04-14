local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

vim.pack.add { Utils.gh 'folke/snacks.nvim' }

require('snacks').setup {
  bigfile = { enabled = true },
  input = { prompt_pos = 'left', win = { relative = 'cursor', width = 40 } },
  picker = {
    layout = function(source)
      return source == 'select' and 'select' or 'default_reverse'
    end,
    layouts = {
      default_reverse = {
        reverse = true,
        layout = {
          box = 'horizontal',
          width = 0.8,
          min_width = 120,
          height = 0.8,
          {
            box = 'vertical',
            border = true,
            title = '{title} {live} {flags}',
            { win = 'list', border = 'none' },
            { win = 'input', height = 1, border = 'top' },
          },
          { win = 'preview', title = '{preview}', border = true, width = 0.5 },
        },
      },
    },
  },
}

autocmd('User', {
  group = augroup('LspHandleFileRename', { clear = true }),
  pattern = 'OilActionsPost',
  callback = function(event)
    for _, action in pairs(event.data.actions) do
      if action.type == 'move' then
        Snacks.rename.on_rename_file(action.src_url, action.dest_url)
      end
    end
  end,
})

local keys = {
  { '<leader>sf', Snacks.picker.files, desc = '[S]earch [F]ile' },
  { '<leader>sh', Snacks.picker.help, desc = '[S]earch [H]elp' },
  { '<leader>sr', Snacks.picker.registers, desc = '[S]earch [R]egister' },
  { '<leader>sb', Snacks.picker.buffers, desc = '[S]earch [B]uffer' },
  { '<leader>ss', Snacks.picker.grep_word, desc = '[S]earch [S]tring' },
  { '<leader>sg', Snacks.picker.grep, desc = '[S]earch [G]rep' },
  { '<leader>sk', Snacks.picker.keymaps, desc = '[S]earch [K]eymap' },
  { '<leader>sc', Snacks.picker.autocmds, desc = '[S]earch [C]ommands' },
  { '<leader>sl', Snacks.picker.lines, desc = '[S]earch [L]ines' },
}
for _, v in pairs(keys) do
  vim.keymap.set('n', v[1], v[2], { desc = v.desc })
end
