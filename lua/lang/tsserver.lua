local nvim_lsp = require("lspconfig")
local on_attach = require("lang.on_attach")
local parsers = require("nvim-treesitter.parsers")
local Query = require("refactoring.query")
local TreeSitter = require("refactoring.treesitter")
local Config = require("refactoring.config")
local utils = require("refactoring.utils")
local LspDefinition = require("refactoring.lsp")
local lsp_utils = require("refactoring.lsp_utils")
local ts_utils = require("nvim-treesitter.ts_utils")

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

local function invert_if(params, children)
  return {
    title = "invert if",
    action = function()
      local if_start_line, if_start_column, if_end_line, if_end_column = children[2]:range()
      local else_children = ts_utils.get_named_children(children[3])
      local else_start_line, else_start_column, else_end_line, else_end_column = else_children[1]:range()
      local text_edits = {
        {
          range = {
            start = { line = if_start_line, character = if_start_column },
            ["end"] = { line = if_end_line, character = if_end_column },
          },
          newText = table.concat(utils.get_node_text(else_children[1]), " "),
        },
        {
          range = {
            start = { line = else_start_line, character = else_start_column },
            ["end"] = { line = else_end_line, character = else_end_column },
          },
          newText = table.concat(utils.get_node_text(children[2]), " "),
        },
      }
      vim.lsp.util.apply_text_edits(text_edits, params.bufnr)
      vim.lsp.buf.formatting_sync()
    end,
  }
end

local function replace_node_with(params, node, newText)
  local start_line, start_column, end_line, end_column = node:range()
  local text_edits = {
    {
      range = {
        start = { line = start_line, character = start_column },
        ["end"] = { line = end_line, character = end_column },
      },
      newText = newText,
    },
  }
  vim.lsp.util.apply_text_edits(text_edits, params.bufnr)
  vim.lsp.buf.formatting_sync()
end

local my_codeaction_source = {
  name = "myCodeActions",
  method = require("null-ls").methods.CODE_ACTION,
  filetypes = {
    "javascript",
    "typescript",
    "typescriptreact",
    "javascriptreact",
  },
  generator = {
    fn = function(params)
      local node = ts_utils:get_node_at_cursor()
      local children = ts_utils.get_named_children(node)
      local result = {}

      if node:type() == "if_statement" and #children > 2 then
        table.insert(result, invert_if(params, children))
      elseif node:type() == "true" then
        table.insert(result, {
          title = "Replace with false",
          action = function()
            replace_node_with(params, node, "false")
          end,
        })
      elseif node:type() == "false" then
        table.insert(result, {
          title = "Replace with true",
          action = function()
            replace_node_with(params, node, "true")
          end,
        })
      end

      -- local lsp_definition = LspDefinition:from_cursor(params.bufnr, refactor.query)
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
      -- print("DOING IT!", vim.inspect(extract_node:type()))
      -- print("DOING IT!", vim.inspect(utils.get_node_text(extract_node)))
      -- print("DOING IT!", vim.inspect(#children))
      -- print("DOING IT!", vim.inspect(children[1]:type()), vim.inspect(children[2]:type()))
      --
      return result
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
  local null_ls = require("null-ls")
  null_ls.setup({
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
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    },
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
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    },
  })
end

return setup
