local M = {}

local lsp_providers = {
  tsserver = true,
  -- pylsp = true,
  pyright = true,
  pyre = true,
  jsonls = true,
  -- efm = true,
  sumneko_lua = true,
  vimls = true,
  volar = true,
  html = true,
  bashls = true,
  cssls = true,
  clojure_lsp = true,
  ocamlls = true,
  yamlls = true,
}

local function setup_servers()
  -- local lsp_installer = require("nvim-lsp-installer")

  -- require("config.lsp.null-ls").setup()

  -- lsp_installer.on_server_ready(function(server)
  --   if lsp_providers[server.name] then
  --     local server_opts = require("config.lsp." .. server.name).setup(server)
  --     if server_opts then
  --       server:setup(server_opts)
  --     end
  --   else
  --     local lsputils = require("config.lsp.utils")
  --     local opts = {
  --       on_attach = lsputils.lsp_attach,
  --       capabilities = lsputils.get_capabilities(),
  --       on_init = lsputils.lsp_init,
  --       on_exit = lsputils.lsp_exit,
  --     }
  --     server:setup(opts)
  --   end
  -- end)
end

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

function M.setup()
  setup_servers()
end

return M
