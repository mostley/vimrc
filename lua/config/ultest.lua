local utils = require('utils')

vim.g.ultest_use_pty = 1

local M = {}

function M.setup()
    local builders = {
        python = function(cmd)
            local non_modules = {"python", "pyenv", "poetry"}

            local module_index
            if vim.tbl_contains(non_modules, cmd[1]) then
                module_index = 3
            else
                module_index = 1
            end

            local args = vim.list_slice(cmd, module_index + 1)

            return {
                dap = {
                    type = "python",
                    name = "Ultest Debugger",
                    request = "launch",
                    module = cmd[module_index],
                    args = args,
                    justMyCode = false
                }
            }
        end,
    }
    require("ultest").setup({builders = builders})
end


return M
