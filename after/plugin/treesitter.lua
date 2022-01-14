local ok, _ = pcall(require, 'nvim-treesitter')
if not ok then
  return
end

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.vim = {
  install_info = {
    url = "~/Documents/dev/tree-sitter-viml", -- local path or git repo
    files = {"src/parser.c", "src/scanner.c"}
  },
  filetype = "vim", -- if filetype does not agrees with parser name
}

local maintained_parsers = require'nvim-treesitter.parsers'.maintained_parsers()

require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
    custom_captures = {
      ["variable"] = "Identifier",
      ["variable.parameter"] = "Identifier",
      --["field"] = "Identifier",
    },
    additional_vim_regex_highlighting = true,
    disable = {},
  },
  textobjects = {
    lsp_interop = {
      enable = true,
      border = 'rounded',
      peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["<leader>dF"] = "@class.outer",
      },
    },
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_event = {"BufWrite", "CursorHold"},
  }
}
