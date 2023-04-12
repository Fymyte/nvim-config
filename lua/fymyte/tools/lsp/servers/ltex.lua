local custom_attach = require('fymyte.tools.lsp').attach

local ltex_languages = {
  'auto',
  'ar',
  'ast-ES',
  'be-BY',
  'br-FR',
  'ca-ES',
  'ca-ES-valencia',
  'da-DK',
  'de',
  'de-AT',
  'de-CH',
  'de-DE',
  'de-DE-x-simple-language',
  'el-GR',
  'en',
  'en-AU',
  'en-CA',
  'en-GB',
  'en-NZ',
  'en-US',
  'en-ZA',
  'eo',
  'es',
  'es-AR',
  'fa',
  'fr',
  'ga-IE',
  'gl-ES',
  'it',
  'ja-JP',
  'km-KH',
  'nl',
  'nl-BE',
  'pl-PL',
  'pt',
  'pt-AO',
  'pt-BR',
  'pt-MZ',
  'pt-PT',
  'ro-RO',
  'ru-RU',
  'sk-SK',
  'sl-SI',
  'sv',
  'ta-IN',
  'tl-PH',
  'uk-UA',
  'zh-CN',
}

return function()
  local function setup_ltex(lang)
    local config = {
      on_attach = function(client, bufnr)
        custom_attach(client, bufnr)
        require('ltex_extra').setup {
          load_langs = { 'en-US', 'fr-FR' },
          -- init_check = true,
          path = vim.fn.stdpath 'config' .. '/spell/dictionaries',
        }
        vim.api.nvim_create_user_command('LtexSwitchLang', function(args)
          local splited_args = vim.split(args.args, ' ', { trimemtpy = true })
          -- local ltex_clients = vim.lsp.get_active_clients({bufnr=0, name="ltex"})
          -- for _, ltex_client in ipairs(ltex_clients) do
          --   vim.lsp.stop_client(ltex_client.id, false)
          -- end
          setup_ltex(splited_args[1])
        end, {
          nargs = 1,
          complete = function(ArgLead, _, _)
            return vim.tbl_filter(function(el)
              return el:find(ArgLead, 1, true)
            end, ltex_languages)
          end,
        })
      end,
      settings = {
        ['ltex'] = {
          configurationTarget = {
            dictionary = 'user',
            disabledRules = 'workspaceFolderExternalFile',
            hiddenFalsePositives = 'workspaceFolderExternalFile',
          },
          language = lang,
        },
      },
    }
    require('lspconfig')['ltex'].setup(config)
  end
  setup_ltex 'en-US'
end
