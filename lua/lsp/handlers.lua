local M = {}
local lsp_keymappings = require("keymap").lsp_keymappings
local keymap = require("utils.keymap")

local servers_without_formatting = {
  tsserver = true,
  css = true,
  volar = true,
  html = true,
  pylsp = true,
  lua = true,
  sumneko_lua = true,
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
  if client.server_capabilities.documentHighlightProvider then
    local status_ok, illuminate = pcall(require, "illuminate")
    if not status_ok then
      return
    end
    illuminate.on_attach(client)
  end
end

M.on_attach = function(client, bufnr)
  vim.notify(client.name)

  lsp_highlight_document(client)

  for mode, mapping in pairs(lsp_keymappings) do
    keymap.map(mode, mapping)
  end

  if client.server_capabilities.documentFormattingProvider then
    if vim.fn.exists("#format_on_save#BufWritePre") == 0 then
      M.enable_format_on_save()
    end
  end

  if servers_without_formatting[client.name] then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end
end

local capabilities = {
  textDocument = {
    completion = {
      completionItem = {
        snippetSupport = true,
      },
    },
  },
}

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  vim.notify("failed to load cmp_nvim_lsp", vim.log.levels.ERROR)
  return
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

function M.enable_format_on_save()
  vim.cmd([[
    augroup format_on_save
      autocmd!
      autocmd BufWritePre * lua vim.lsp.buf.format({ async=false })
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

vim.api.nvim_create_user_command("LspToggleAutoFormat", function()
  require("lsp.handlers").toggle_format_on_save()
end, {
  desc = "Toggle the format on save functionality",
})

return M
