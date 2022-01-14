USER = vim.fn.expand("$USER")

vim.lsp.protocol.CompletionItemKind = {
  " [text]",
  " [method]",
  " [function]",
  " [constructor]",
  "ﰠ [field]",
  " [variable]",
  " [class]",
  " [interface]",
  " [module]",
  " [property]",
  " [unit]",
  " [value]",
  " [enum]",
  " [key]",
  "﬌ [snippet]",
  " [color]",
  " [file]",
  " [reference]",
  " [folder]",
  " [enum member]",
  " [constant]",
  " [struct]",
  "⌘ [event]",
  " [operator]",
  " [type]",
}

-- LSP Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  underline = true,
  signs = true,
  update_in_insert = false,
})

-- vim.cmd [[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]]
vim.cmd([[autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()]])

vim.api.nvim_exec(
  [[
    augroup FormatAutogroup
    autocmd!
    autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.lua,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html,*.rs,*.py,*.clj lua vim.lsp.buf.formatting_sync(nil, 5000)
    augroup END
  ]],
  true
)

vim.fn.sign_define("LspDiagnosticsSignError", { text = "", numhl = "LspDiagnosticsDefaultError" })
vim.fn.sign_define("LspDiagnosticsSignWarning", { text = "", numhl = "LspDiagnosticsDefaultWarning" })
vim.fn.sign_define("LspDiagnosticsSignInformation", { text = "", numhl = "LspDiagnosticsDefaultInformation" })
vim.fn.sign_define("LspDiagnosticsSignHint", { text = "", numhl = "LspDiagnosticsDefaultHint" })
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Code actions
capabilities.textDocument.codeAction = {
  dynamicRegistration = true,
  codeActionLiteralSupport = {
    codeActionKind = {
      valueSet = (function()
        local res = vim.tbl_values(vim.lsp.protocol.CodeActionKind)
        table.sort(res)
        return res
      end)(),
    },
  },
}

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

-- Language specific key mappings
require("lang.keymappings")

require("lang.lua")(capabilities)
require("lang.pyls")(capabilities)
require("lang.tsserver")(capabilities)
require("lang.efm")(capabilities)
require("lang.vimls")(capabilities)
require("lang.vuels")(capabilities)
require("lang.html")(capabilities)
require("lang.bash")()
require("lang.css")()
require("lang.clojure")()
require("lang.ocaml")()

-- symbols-outline.nvim
vim.g.symbols_outline = {
  highlight_hovered_item = true,
  show_guides = true,
  show_relative_numbers = true,
  auto_preview = false, -- experimental
  position = "right",
  keymaps = {
    close = "<Esc>",
    goto_location = "<Cr>",
    focus_location = "o",
    hover_symbol = "<C-space>",
    rename_symbol = "r",
    code_actions = "a",
  },
  lsp_blacklist = {},
}
