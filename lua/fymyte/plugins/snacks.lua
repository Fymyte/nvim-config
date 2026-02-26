local augroup = require('fymyte.utils').augroup

---@type snacks.picker.layout.Config
local default_reverse = {
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
}
---@type LazyPluginSpec
return {
  'folke/snacks.nvim',
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    input = { prompt_pos = 'left', win = { relative = 'cursor', width = 40 } },
    picker = { layout = default_reverse },
  },

  config = function(_, opts)
    require('snacks').setup(opts)

    vim.api.nvim_create_autocmd('User', {
      group = augroup 'LspHandleFileRename',
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
    }
    for _, v in pairs(keys) do
      vim.keymap.set('n', v[1], v[2], { desc = v.desc })
    end
  end,
}
