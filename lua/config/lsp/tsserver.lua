local lsputils = require("config.lsp.utils")

local Query = require("refactoring.query")
local TreeSitter = require("refactoring.treesitter")
local Config = require("refactoring.config")
local utils = require("refactoring.utils")
local tresssitter_utils = require("nvim-treesitter.ts_utils")

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
      local else_children = tresssitter_utils.get_named_children(children[3])
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
      local node = tresssitter_utils:get_node_at_cursor()
      local children = tresssitter_utils.get_named_children(node)
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

local M = {}

-- M.setup = function(capabilities)
--   nvim_lsp.tsserver.setup({
--     capabilities = capabilities,
--     init_options = {
--       hostInfo = "neovim",
--     },
--     on_attach = function(client, bufnr)
--       client.resolved_capabilities.document_formatting = false
--       client.resolved_capabilities.document_range_formatting = false
--
--       on_attach(client, bufnr)
--
--       local ts_utils = require("nvim-lsp-ts-utils")
--       ts_utils.setup(ts_utils_settings)
--       ts_utils.setup_client(client)
--
--       local opts = { silent = true }
--       vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ao", ":TSLspOrganize<CR>", opts)
--       vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>an", ":TSLspRenameFile<CR>", opts)
--       vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ai", ":TSLspImportAll<CR>", opts)
--     end,
--     flags = {
--       -- This will be the default in neovim 0.7+
--       debounce_text_changes = 150,
--     },
--   })
-- end

function M.lsp_attach(client, bufnr)
  lsputils.lsp_attach(client, bufnr)

  -- disable tsserver formatting if you plan on formatting via null-ls
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false

  local ts_utils = require("nvim-lsp-ts-utils")

  -- defaults
  ts_utils.setup({
    debug = false,
    disable_commands = false,
    enable_import_on_completion = true,

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
    eslint_enable_code_actions = false,
    eslint_enable_disable_comments = true,
    eslint_bin = "eslint",
    eslint_enable_diagnostics = false,
    eslint_opts = {},

    -- formatting
    enable_formatting = false,
    formatter = "prettier",
    formatter_opts = {},

    -- update imports on file move
    update_imports_on_move = false,
    require_confirmation_on_move = false,
    watch_dir = nil,

    -- filter diagnostics
    filter_out_diagnostics_by_severity = {},
    filter_out_diagnostics_by_code = {},
  })

  -- required to fix code action ranges and filter diagnostics
  ts_utils.setup_client(client)
end

function M.config(_)
  return {
    on_attach = M.lsp_attach,
    capabilities = lsputils.get_capabilities(),
    on_init = lsputils.lsp_init,
    on_exit = lsputils.lsp_exit,
    flags = { debounce_text_changes = 150 },
  }
end

function M.setup(installed_server)
  return M.config(installed_server)
end

return M
