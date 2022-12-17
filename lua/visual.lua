--[[
 ___      ___ ___  ________  ___  ___  ________  ___
|\  \    /  /|\  \|\   ____\|\  \|\  \|\   __  \|\  \
\ \  \  /  / | \  \ \  \___|\ \  \\\  \ \  \|\  \ \  \
 \ \  \/  / / \ \  \ \_____  \ \  \\\  \ \   __  \ \  \
  \ \    / /   \ \  \|____|\  \ \  \\\  \ \  \ \  \ \  \____
   \ \__/ /     \ \__\____\_\  \ \_______\ \__\ \__\ \_______\
    \|__|/       \|__|\_________\|_______|\|__|\|__|\|_______|
                     \|_________|

--]]

local M = {}

local colors = require("colors")

local function fg(group, color)
  vim.cmd("hi " .. group .. " guifg=" .. color)
end

local function fg_nocombine(group, color)
  vim.cmd("hi " .. group .. " guifg=" .. color .. " gui=nocombine")
end

local function underline(group, color)
  vim.cmd("hi " .. group .. " guisp=" .. color .. " gui=underline")
end

local function bg(group, color)
  vim.cmd("hi " .. group .. " guibg=" .. color)
end

local function fg_bg(group, fgcol, bgcol)
  vim.cmd("hi " .. group .. " guifg=" .. fgcol .. " guibg=" .. bgcol)
end

function M.setup()
  local colorscheme = "gruvbox"

  local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
  if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!", "error")
    return
  end

  vim.cmd([[
    set guifont=CaskaydiaCove\ Nerd\ Font:h14
  ]])

  vim.g.gruvbox_contrast_dark = "hard"
  vim.g.gruvbox_invert_selection = "0"
  vim.cmd([[colorscheme gruvbox]])

  fg_nocombine("IndentBlanklineContextChar", colors.light_grey)
  underline("IndentBlanklineContextStart", colors.light_grey)
  vim.g.neovide_cursor_vfx_mode = "wireframe"
end

return M
