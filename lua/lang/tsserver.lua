local nvim_lsp = require("lspconfig")
local on_attach = require("lang.on_attach")
local null_ls = require("null-ls")
local parsers = require("nvim-treesitter.parsers")
local Query = require("refactoring.query")
local TreeSitter = require("refactoring.treesitter")
local Config = require("refactoring.config")
local utils = require("refactoring.utils")

local function refactor_from_action(params)
  local root = Query.get_root(params.bufnr, params.ft)
  local config = Config.get_config()
  return {
    code = config.get_code_generation_for(params.ft),
    ts = TreeSitter.get_treesitter(),
    filetype = params.ft,
    bufnr = params.bufnr,
    query = Query:new(params.bufnr, params.ft, vim.treesitter.get_query(params.ft, "refactoring")),
    locals = Query:new(params.bufnr, params.ft, vim.treesitter.get_query(params.ft, "locals")),
    root = root,
    options = config,
    buffers = { bufnr = params.bufnr },
  }
end

local function range_from_params(params)
  return params.range.row - 1, params.range.col, params.range.end_row - 1, params.range.end_col
end

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
            local refactor = refactor_from_action(params)
            local range = range_from_params(params)
            -- local extract_node = refactor.root:named_descendant_for_range(range)
            local extract_node = refactor.root:named_descendant_for_range(range)
            -- child = <function 5>,
            -- child_count = <function 6>,
            -- descendant_for_range = <function 7>,
            -- end_ = <function 8>,
            -- field = <function 9>,
            -- has_error = <function 10>,
            -- id = <function 11>,
            -- iter_children = <function 12>,
            -- missing = <function 13>,
            -- named = <function 14>,
            -- named_child = <function 15>,
            -- named_child_count = <function 16>,
            -- named_descendant_for_range = <function 17>,
            -- parent = <function 18>,
            -- range = <function 19>,
            -- sexpr = <function 20>,
            -- start = <function 21>,
            -- symbol = <function 22>,
            -- type = <function 23>

            -- print("DOING IT!", vim.inspect(params))
            -- print("DOING IT!", vim.inspect(getmetatable(extract_node)))
            print("DOING IT!", vim.inspect(extract_node:type()))
            -- print("DOING IT!", vim.inspect(utils.get_node_text(extract_node)))
          end,
        },
      }
    end,
  },
}

local ts_utils_settings = {
  debug = true,
  enable_import_on_completion = false,

  eslint_enable_code_actions = true,
  eslint_enable_disable_comments = true,
  eslint_enable_diagnostics = false,
  eslint_bin = "eslint_d",
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
