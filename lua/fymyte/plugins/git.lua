return {
  ---------------
  ----- Git -----
  ---------------

  -- Git on steroids
  {
    'tpope/vim-fugitive',
    config = function()
      vim.api.nvim_create_autocmd('BufReadPost', {
        pattern = 'fugitive://*',
        callback = function()
          vim.b.bufhidden = 'delete'
        end,
      })
    end,
  },
  -- GitHub/GitLab in neovim
  { 'tpope/vim-rhubarb', enabled = false },
  -- Git hunks displayed inline
  {
    'lewis6991/gitsigns.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    event = 'BufReadPre',
    opts = {
      on_attach = function(bufnr)
        local gs = require 'gitsigns'
        local opts = { noremap = true, silent = true }
        local function map(mode, l, r, lopts)
          lopts = vim.tbl_extend('force', opts, lopts or {})
          lopts.buffer = bufnr
          vim.keymap.set(mode, l, r, lopts)
        end

        -- Navigation
        map('n', ']h', function()
          if vim.wo.diff then
            return ']h'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Next [H]unk' })

        map('n', '[h', function()
          if vim.wo.diff then
            return '[h'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Prev [H]unk' }) -- Actions

        map({ 'n', 'v' }, '<leader>hs', gs.stage_hunk, { desc = '[H]unk [S]tage' })
        map({ 'n', 'v' }, '<leader>hr', gs.reset_hunk, { desc = '[H]unk [R]eset' })
        map('n', '<leader>hS', gs.stage_buffer, { desc = '[H]unk [S]tage buffer' })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = '[H]unk [U]ndo stage' })
        map('n', '<leader>hR', gs.reset_buffer, { desc = '[H]unk [R]eset buffer' })
        map('n', '<leader>hp', gs.preview_hunk, { desc = '[H]unk [P]review' })
        map('n', '<leader>hb', function()
          gs.blame_line { full = true }
        end, { desc = '[H]unk [B]lame' })
        map('n', '<leader>thb', gs.toggle_current_line_blame, { desc = '[T]oggle [H]unk [B]lame' })
        map('n', '<leader>hd', gs.diffthis, { desc = '[H]unk [D]iff index' })
        map('n', '<leader>hD', function()
          gs.diffthis '~'
        end, { desc = '[H]unk [D]iff last commit' })
        map('n', '<leader>thd', gs.toggle_deleted, { desc = '[T]oggle [H]unk [D]eleted lines' })
      end,
      preview_config = {
        border = 'rounded',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1,
      },
      yadm = {
        enable = false,
      },
    },
  },
}
