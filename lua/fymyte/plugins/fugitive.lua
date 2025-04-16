local augroup = require('fymyte.utils').augroup
local autocmd = vim.api.nvim_create_autocmd

---@type LazyPluginSpec
return {
  'tpope/vim-fugitive',
  cmd = { 'Git', 'G' },
  keys = '<leader>tg',
  config = function()
    local function open_fugitive_buf()
      local ok, head = pcall(vim.fn.FugitiveHead)
      if ok and head ~= '' then
        vim.cmd.Git()
      end
    end

    local function get_fugitive_buf()
      return vim.fn.bufnr 'fugitive:///*/.git/{worktrees/*}\\\\\\{0,1\\}/$'
    end

    local function close_fugitive_buf()
      local fugitive_buf = get_fugitive_buf()
      if fugitive_buf ~= -1 then
        vim.api.nvim_buf_delete(fugitive_buf, {})
      end
    end

    function ToggleFugitiveGit()
      local fugitive_buf = get_fugitive_buf()
      if fugitive_buf ~= -1 then
        close_fugitive_buf()
      else
        open_fugitive_buf()
      end
    end

    local fugitive_grp = vim.api.nvim_create_augroup('fugitive_autocmd', { clear = true })
    autocmd('BufReadPost', {
      group = fugitive_grp,
      desc = 'mark fugitive buffers as delete on quit',
      pattern = 'fugitive://*',
      callback = function()
        vim.b.bufhidden = 'delete'
      end,
    })

    autocmd('DirChanged', {
      group = fugitive_grp,
      desc = 'Update fugitive status when changing cwd',
      callback = function()
        close_fugitive_buf()

        -- TODO: currently, opening fugitive buf right here actually make the closing of the previous buffer fail.
      end,
    })

    autocmd('User', {
      group = fugitive_grp,
      desc = 'open commit message in vsplit on the far left',
      pattern = 'FugitiveEditor',
      callback = function()
        vim.cmd.wincmd 'H'
        vim.cmd [[vertical resize 80]]
        vim.cmd.setlocal 'nonumber'
        vim.cmd.setlocal 'norelativenumber'
        vim.cmd.setlocal 'winfixwidth'
      end,
    })

    autocmd('User', {
      group = fugitive_grp,
      pattern = 'FugitiveIndex',
      desc = 'Resize fugigive index window',
      callback = function()
        vim.cmd.resize(10)
        vim.cmd.setlocal 'nonumber'
        vim.cmd.setlocal 'norelativenumber'
        vim.cmd.setlocal 'winfixheight'
      end,
    })

    vim.keymap.set('n', '<leader>tg', ToggleFugitiveGit)
  end,
}
