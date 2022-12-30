local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  vim.notify("failed to load lualine", vim.log.levels.ERROR)
  return
end

local M = {}

function M.setup()
  local function lsp_server_name()
    local msg = "No Active Lsp"
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end
  -- icon = ' LSP:',
  -- color = { fg = '#ffffff', gui = 'bold' },

  local config = {
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "|", right = "|" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {},
      always_divide_middle = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { { lsp_server_name, icons_enabled = true, icon = " LSP:" }, "filename" },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = { "filename" },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    tabline = {
      lualine_a = {
        {
          "filename",
          file_status = true,
          path = 1,
          shortening_target = 120,
          symbols = {
            modified = "*", -- Text to show when the file is modified.
            readonly = " <readonly>", -- Text to show when the file is non-modifiable or readonly.
            unnamed = "[No Name]", -- Text to show for unnamed buffers.
          },
        },
      },
    },
    extensions = { "aerial", "fzf", "toggleterm" },
  }

  lualine.setup(config)
end

return M
