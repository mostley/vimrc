local nvim_lsp = require('lspconfig')
local on_attach = require('lang.on_attach')

local efm_config = os.getenv('HOME') .. '/.config/nvim/lua/lsp/efm/config.yaml'
local efm_log_dir = '/tmp/'
local efm_root_markers = { 'package.json', '.git/', '.zshrc' }

local prettier = {
  formatCommand = 'prettierd ${INPUT}',
  formatStdin = true,
  env = {
    'PRETTIERD_DEFAULT_CONFIG=/Users/svenhecht/.config/nvim/utils/linter-config/.prettierrc.json',
  },
}
local eslint = {
    lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"},
    lintIgnoreExitCode = true,
    formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
    formatStdin = true
}
local luaFormat = {
    formatCommand = "luafmt --stdin",
    formatStdin = true
}
local yaml = {
    lintCommand = "yamllint -f parsable -",
    lintStdin = true
}

local efm_languages = {
  escript = {eslint, prettier},
  lua = {luaFormat},
  yaml = { yaml, prettier },
  markdown = { prettier },
  javascript = { eslint, prettier },
  javascriptreact = { eslint, prettier },
  typescript = { eslint, prettier },
  typescriptreact = { eslint, prettier },
  css = { prettier },
  scss = { prettier },
  sass = { prettier },
  less = { prettier },
  json = { prettier },
  graphql = { prettier },
  vue = { prettier, eslint },
  html = { prettier }
}


local function setup(capabilities)
  nvim_lsp.efm.setup {
      filetype = {
          "javascript",
          "typescript",
          "typescriptreact",
          "javascriptreact",
          "lua",
          "yaml"
      },
      capabilities = capabilities,
      on_attach = on_attach,
      root_dir = nvim_lsp.util.root_pattern(unpack(efm_root_markers)),
      init_options = { documentFormatting = true, codeAction = true },
      settings = {
          rootMarkers = efm_root_markers,
          languages = efm_languages
      },
  }
end

return setup
