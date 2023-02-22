return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup()
    mason_lspconfig.setup()

    local opts = {
      on_attach = require("lsp.handlers").on_attach,
      capabilities = require("lsp.handlers").capabilities,
    }
    require("mason-lspconfig").setup_handlers({
      -- The first entry (without a key) will be the default handler
      -- and will be called for each installed server that doesn't have
      -- a dedicated handler.
      function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup(opts)
      end,
      -- Next, you can provide a dedicated handler for specific servers.
      ["rust_analyzer"] = function()
        require("lspconfig").rust_analyzer.setup(opts)
        require("rust-tools").setup({})
      end,
      ["lua_ls"] = function()
        local lua_opts = require("lsp.settings.lua_ls")
        lua_opts = vim.tbl_deep_extend("force", lua_opts, opts)
        require("lspconfig")["lua_ls"].setup(lua_opts)
      end,
      ["pylsp"] = function()
        local pylsp_opts = require("lsp.settings.pylsp")
        pylsp_opts = vim.tbl_deep_extend("force", pylsp_opts, opts)
        require("lspconfig")["pylsp"].setup(pylsp_opts)
      end,
    })
  end,
}
