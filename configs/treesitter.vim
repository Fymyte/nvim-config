
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "rust", "c", "cpp", "bash", "cuda", "cmake", "vim" },
  highlight = {
    enable = true,
    custom_captures = {
      ["variable"] = "Identifier",
    },
    additional_vim_regex_highlighting = true,
      disable = { "fsharp" },
  },
  
}
EOF
