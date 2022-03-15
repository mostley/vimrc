local M = {}

function M.setup()
        require("neoscroll").setup()
        local t = {}
        t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "150", [['sine']] } }
        t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "150", [['sine']] } }
        require("neoscroll.config").set_mappings(t)
end

return M
