local autocmd = require('fymyte.utils').autocmd

return {
  ---------------
  ----- Git -----
  ---------------

  -- Git on steroids
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
    config = function()
      local fugitive_grp = vim.api.nvim_create_augroup('fugitive_autocmd', { clear = true })
      autocmd('BufReadPost', {
        group = fugitive_grp,
        desc = 'mark fugitive buffers as delete on quit',
        pattern = 'fugitive://*',
        callback = function()
          vim.b.bufhidden = 'delete'
        end,
      })

      autocmd('BufAdd', {
        group = fugitive_grp,
        desc = 'open commit message in vsplit on the far left',
        pattern = '*/.git/COMMIT_EDITMSG',
        callback = function()
          vim.cmd.wincmd 'H'
          vim.cmd [[vertical resize 80]]
          vim.cmd.setlocal 'nonumber'
          vim.cmd.setlocal 'norelativenumber'
          vim.cmd.setlocal 'winfixwidth'
        end,
      })

      local function showFugitiveGit()
        local is_git_dir = function()
          if pcall(require, 'lualine.components.branch.git_branch') then
            print 'using lualine get_branch'
            return require('lualine.components.branch.git_branch').get_branch() ~= ''
          else
            local ok, head = pcall(vim.fn.FugitiveHead)
            return ok and head ~= ''
          end
        end
        if is_git_dir() then
          vim.cmd.Git()
          vim.cmd.resize(10)
          vim.cmd.setlocal 'nonumber'
          vim.cmd.setlocal 'norelativenumber'
          vim.cmd.setlocal 'winfixheight'
        end
      end

      function ToggleFugitiveGit()
        if
          vim.fn.buflisted(
            ---@diagnostic disable-next-line:param-type-mismatch
            vim.fn.bufname 'fugitive:///*/.git//$'
          ) ~= 0
        then
          vim.cmd [[ execute ":bdelete" bufname('fugitive:///*/.git//$') ]]
        else
          showFugitiveGit()
        end
      end
      vim.keymap.set('n', '<leader>tg', ToggleFugitiveGit)
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
    },
  },

  {
    'harrisoncramer/gitlab.nvim',
    -- Only if we have go installed, to not have error on startup
    cond = function()
      return vim.fn.executable 'go' == 1
    end,
    enabled = true,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'stevearc/dressing.nvim', -- Recommended but not required. Better UI for pickers.
    },
    build = function () require("gitlab.server").build(true) end,
    opts = {
      keymaps = {
        discussion_tree = {
          toggle_node = "<cr>",
        },
        popup = {
          perform_action = '<leader>w',
          discard_changes = "q",
        },
      },
      reviewer_settings = {
        diffview = {
          imply_local = true,
        },
      },
      popup = {
        border = 'solid',
        temp_registers = {'"', '+', 'g'},
      },
      discussion_tree = {
        size = '15%',
      },
    },
    config = true,
  },
}
