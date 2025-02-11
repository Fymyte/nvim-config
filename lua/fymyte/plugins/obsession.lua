return {
  'tpope/vim-obsession',
  config = function(_, _)
    local session_filename = '.session.vim'
    local session_file = vim.fn.findfile(session_filename, ',,')
    if session_file and #session_file > 0 then
      vim.cmd('source', 'session_file')
      vim.cmd.Obsession { session_file, mods = { silent = true } }
    end
  end,
}
