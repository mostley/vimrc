local M = {}
local lsp_keymappings = require("keymap").lsp_keymappings

local servers_without_formatting = {
  "tsserver",
  "css",
  "vuels",
  "html",
}

M.setup = function()
  local icons = require("icons")
  local signs = {
    { name = "DiagnosticSignError", text = icons.diagnostics.Error },
    { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
    { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
    { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = true,
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = false,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_highlight_document(client)
  if client.resolved_capabilities.document_highlight then
    local status_ok, illuminate = pcall(require, "illuminate")
    if not status_ok then
      return
    end
    illuminate.on_attach(client)
  end
end

local notify_status_ok, notify = pcall(require, "notify")
if not notify_status_ok then
  vim.notify("failed to load notify", "error")
  return
end

M.on_attach = function(client, bufnr)
  notify(client.name)

  if servers_without_formatting[client.name] then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end

  require("lsp_signature").on_attach({
    bind = true,
    handler_opts = { border = "single" },
  })

  lsp_highlight_document(client)

  local keymap = require("utils.keymap")
  for mode, mapping in pairs(lsp_keymappings) do
    keymap.map(mode, mapping)
  end

  if client.resolved_capabilities.document_formatting then
    if vim.fn.exists("#format_on_save#BufWritePre") == 0 then
      M.enable_format_on_save()
    end
  end

  -- virtualtypes.on_attach()
  -- Call the setup function to change the default behavior
  require("aerial").setup({
    backends = { "lsp", "treesitter", "markdown" },
    close_behavior = "auto",
    default_bindings = true,
    default_direction = "prefer_right",
    disable_max_lines = 10000,
    filter_kind = {
      "Class",
      "Constructor",
      "Enum",
      "Function",
      "Interface",
      "Module",
      "Method",
      "Struct",
    },

    highlight_mode = "split_width",
    highlight_closest = true,
    highlight_on_jump = 300,
    icons = {},
    link_folds_to_tree = false,
    link_tree_to_folds = true,
    manage_folds = false,
    max_width = 55,
    min_width = 10,
    nerd_font = "auto",
    on_attach = nil,
    open_automatic = false,
    placement_editor_edge = false,
    post_jump_cmd = "normal! zz",
    close_on_select = false,
    show_guides = true,
    guides = {
      mid_item = "├─",
      last_item = "└─",
      nested_top = "│ ",
      whitespace = "  ",
    },
    float = {
      border = "rounded",
      -- row = 1,
      -- col = 0,
      max_height = 100,
      min_height = 4,
    },

    lsp = {
      -- Fetch document symbols when LSP diagnostics update.
      -- If false, will update on buffer changes.
      diagnostics_trigger_update = true,

      -- Set to false to not update the symbols when there are LSP errors
      update_when_errors = true,
    },

    treesitter = {
      -- How long to wait (in ms) after a buffer change before updating
      update_delay = 300,
    },

    markdown = {
      -- How long to wait (in ms) after a buffer change before updating
      update_delay = 300,
    },
  })
  require("aerial").on_attach(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

function M.enable_format_on_save()
  vim.cmd([[
    augroup format_on_save
      autocmd! 
      autocmd BufWritePre * lua vim.lsp.buf.formatting()
    augroup end
  ]])
  vim.notify("Enabled format on save")
end

function M.disable_format_on_save()
  M.remove_augroup("format_on_save")
  vim.notify("Disabled format on save")
end

function M.toggle_format_on_save()
  if vim.fn.exists("#format_on_save#BufWritePre") == 0 then
    M.enable_format_on_save()
  else
    M.disable_format_on_save()
  end
end

function M.remove_augroup(name)
  if vim.fn.exists("#" .. name) == 1 then
    vim.cmd("au! " .. name)
  end
end

vim.cmd([[ command! LspToggleAutoFormat execute 'lua require("lsp.handlers").toggle_format_on_save()' ]])

return M
