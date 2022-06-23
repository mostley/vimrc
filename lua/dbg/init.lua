local M = {}

function M.setup()
    -- telescope-dap
    require('telescope').load_extension('dap')

    -- nvim-dap-virtual-text. Show virtual text for current frame
    vim.g.dap_virtual_text = true

    -- nvim-dap-ui
    require("dapui").setup()

    -- languages
    require('dbg.python')
    require('dbg.node')

    -- nvim-dap
    vim.fn.sign_define('DapBreakpoint',
                    {text = '🟥', texthl = '', linehl = '', numhl = ''})
    vim.fn.sign_define('DapStopped',
                    {text = '⭐️', texthl = '', linehl = '', numhl = ''})
end

return M
