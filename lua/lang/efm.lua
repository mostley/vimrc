local nvim_lsp = require('lspconfig')
local on_attach = require('lang.on_attach')

local efm_root_markers = { 'package.json', '.git/', '.zshrc' }

local function eslint_config_exists()
  local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)

  if not vim.tbl_isempty(eslintrc) then
    return true
  end

  if vim.fn.filereadable("package.json") then
    if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
      return true
    end
  end

  return false
end

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
      filetypes = {
          "javascript",
          "typescript",
          "typescriptreact",
          "javascriptreact",
          "vue",
          "lua",
          "yaml"
      },
      capabilities = capabilities,
      on_attach = function(client)
        client.resolved_capabilities.document_formatting = true
        client.resolved_capabilities.goto_definition = false
        on_attach(client)
      end,
      root_dir = function()
        if not eslint_config_exists() then
          return nil
        end
        return vim.fn.getcwd()
      end,
      init_options = { documentFormatting = true, codeAction = true },
      settings = {
          rootMarkers = efm_root_markers,
          languages = efm_languages
      },
  }
end

return setup
