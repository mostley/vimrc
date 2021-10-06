local nvim_lsp = require("lspconfig")
local on_attach = require("lang.on_attach")

local function setup(capabilities)
  local null_ls = require("null-ls")
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

      local ts_utils = require("nvim-lsp-ts-utils")

      -- defaults
      ts_utils.setup({
        debug = true,
        disable_commands = false,
        enable_import_on_completion = false,

        -- import all
        import_all_timeout = 5000, -- ms
        import_all_priorities = {
          buffers = 4, -- loaded buffer names
          buffer_content = 3, -- loaded buffer content
          local_files = 2, -- git files or files with relative path markers
          same_file = 1, -- add to existing import statement
        },
        import_all_scan_buffers = 100,
        import_all_select_source = false,

        -- eslint
        eslint_enable_code_actions = true,
        eslint_enable_disable_comments = true,
        eslint_bin = "eslint",
        eslint_enable_diagnostics = false,
        eslint_opts = {},

        -- formatting
        enable_formatting = false,
        formatter = "prettier",
        formatter_opts = {},

        -- update imports on file move
        update_imports_on_move = true,
        require_confirmation_on_move = true,
        watch_dir = nil,

        -- filter diagnostics
        filter_out_diagnostics_by_severity = {},
        filter_out_diagnostics_by_code = {},
      })

      -- required to fix code action ranges and filter diagnostics
      ts_utils.setup_client(client)

      local opts = { silent = true }
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ao", ":TSLspOrganize<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>an", ":TSLspRenameFile<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ai", ":TSLspImportAll<CR>", opts)

      on_attach(client, bufnr)
    end,
  })
end

return setup
