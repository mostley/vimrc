local nvim_lsp = require("lspconfig")
local on_attach = require("lang.on_attach")
local null_ls = require("null-ls")

local my_codeaction_source = {
  name = "myCodeActions",
  method = null_ls.methods.CODE_ACTION,
  filetypes = {
    "javascript",
    "typescript",
    "typescriptreact",
    "javascriptreact",
  },
  generator = {
    fn = function(params)
      return {
        {
          title = "invert if",
          action = function()
            print("DOING IT!", vim.inspect(params))
          end,
        },
      }
    end,
  },
}

local ts_utils_settings = {
  -- debug = true,
  enable_import_on_completion = false,

  eslint_enable_code_actions = true,
  eslint_enable_disable_comments = true,
  eslint_enable_diagnostics = false,
  enable_formatting = false,

  update_imports_on_move = true,
  require_confirmation_on_move = true,

  filter_out_diagnostics_by_severity = {},
  filter_out_diagnostics_by_code = {},
}

local function setup(capabilities)
  null_ls.config({
    sources = {
      null_ls.builtins.diagnostics.write_good,
      null_ls.builtins.formatting.shfmt,
      null_ls.builtins.diagnostics.shellcheck,
      null_ls.builtins.formatting.nginx_beautifier,
      null_ls.builtins.code_actions.gitsigns,
      -- null_ls.builtins.formatting.prettier_d
      -- null_ls.builtins.formatting.stylua
      -- null_ls.builtins.formatting.autopep8,
      -- null_ls.builtins.diagnostics.eslint_d
      my_codeaction_source,
    },
  })
  nvim_lsp["null-ls"].setup({
    debug = true,
    capabilities = capabilities,
    on_attach = on_attach,
  })

  nvim_lsp.tsserver.setup({
    capabilities = capabilities,
    init_options = {
      hostInfo = "neovim",
    },
    on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false

      on_attach(client, bufnr)

      local ts_utils = require("nvim-lsp-ts-utils")
      ts_utils.setup(ts_utils_settings)
      ts_utils.setup_client(client)

      local opts = { silent = true }
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ao", ":TSLspOrganize<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>an", ":TSLspRenameFile<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ai", ":TSLspImportAll<CR>", opts)
    end,
  })
end

return setup
