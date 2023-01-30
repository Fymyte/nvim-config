return {
  -- Catppuccin -- Pastel colorscheme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    opts = {
      flavour = 'frappe',
    },
    config = function(_, opts)
      require'catppuccin'.setup (opts)
      vim.cmd.colorscheme 'catppuccin'
    end
  },

  -- Kanagawa -- Inspired by the painting of Katsushika Hokusai
  {
    'rebelot/kanagawa.nvim',
    name = 'kanagawa',
    lazy = true,
  },

  {
    'marko-cerovac/material.nvim',
    lazy = true,
  },
}
