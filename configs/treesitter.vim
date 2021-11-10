
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "rust", "python", "c", "cpp", "bash", "cuda", "cmake", "vim", "lua" },
  highlight = {
    enable = true,
    custom_captures = {
      ["variable"] = "Identifier",
      ["variable.parameter"] = "Identifier"
    },
    additional_vim_regex_highlighting = true,
      disable = { "fsharp" },
  },
  
}
EOF
