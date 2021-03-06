local M = {}
local lsp_keymappings = require("keymap").lsp_keymappings

local servers_without_formatting = {
  tsserver = true,
  css = true,
  volar = true,
  html = true,
  pylsp = true,
  lua = true,
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

  require("lsp.settings.aerial").setup(client, bufnr)

  if servers_without_formatting[client.name] then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  vim.notify("failed to load cmp_nvim_lsp", "error")
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
