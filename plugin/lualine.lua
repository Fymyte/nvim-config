vim.pack.add {
  Utils.gh 'nvim-lualine/lualine.nvim',
  Utils.gh 'linrongbin16/lsp-progress.nvim',
}

require('lsp-progress').setup {
  spinner = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
  client_format = function(client, spinner, _)
    return ('[' .. client .. '] ' .. spinner)
  end,
  format = function(msgs)
    if #msgs > 0 then
      return table.concat(msgs, ' ')
    end
    return ''
  end,
}

require('lualine').setup {
  options = {
    section_separators = '',
    component_separators = { left = '∣', right = '∣' },
    globalstatus = true,
  },
  sections = {
    lualine_b = {
      {
        function()
          local mr = require('fymyte.fugitive').mr()
          return vim.fn.FugitiveHead() .. (mr and ' !' .. mr.id or '')
        end,
        icon = '',
        on_click = function()
          require('fymyte.fugitive').open_mr()
        end,
      },
      'diff',
      {
        'diagnostics',
        sources = { 'nvim_diagnostic', 'nvim_lsp' },
        symbols = { error = ' ', warn = ' ', hint = ' ', info = ' ' },
      },
    },
    lualine_c = { '%=%f', 'filetype' },
    lualine_x = {
      function()
        return require('lsp-progress').progress()
      end,
      'encoding',
      'fileformat',
    },
  },
}

vim.api.nvim_create_autocmd('User', {
  pattern = 'FymyteMrChanged',
  desc = 'Show the MR/PR id as soon as it is fetched',
  callback = function()
    require('lualine').refresh { place = { 'statusline' } }
  end,
})
