USER = vim.fn.expand('$USER')

-- Language specific key mappings
require('lang.keymappings')

local on_attach = function(client, bufnr)

    require'lsp_signature'.on_attach(client)

    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = {noremap = true, silent = true}

    if client.resolved_capabilities.hover then
        buf_set_keymap("n", "K", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
    end
    if client.resolved_capabilities.find_references then
        buf_set_keymap("n", "gr", "<cmd>lua require'telescope.builtin'.lsp_references()<CR>", opts)
    end
    if client.resolved_capabilities.goto_definition then
        buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    end
    if client.resolved_capabilities.rename then
        buf_set_keymap("n", "<leader>rn", "<cmd>lua require'lspsaga.rename'.rename()<CR>", opts)
    end

    buf_set_keymap('n', '<leader>gD',  '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', '<leader>gi',  '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>',       '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- buf_set_keymap('n', 'gp',          '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    -- buf_set_keymap('n', 'gn',          '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', 'gp',          "<cmd>lua <require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()CR>", opts)
    buf_set_keymap('n', 'gn',          "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", opts)
    buf_set_keymap('n', '<leader>law', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>lrw', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>llw', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<leader>lt',  '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    -- buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>rn', "<cmd>lua require'lspsaga.rename'.rename()<CR>", opts)
    buf_set_keymap('n', '<leader>ld',  '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '<leader>ll',  '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    -- buf_set_keymap('n', '<leader>ac', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<leader>ac', '<cmd>lua require\'lspsaga.codeaction\'.code_action()<CR>', opts)
    buf_set_keymap('v', '<leader>ac', '<cmd>lua require\'lspsaga.codeaction\'.range_code_action()<CR>', opts)
    buf_set_keymap('n', '<leader>lss', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_exec([[
            augroup auto_fmt
                autocmd!
                autocmd BufWritePre *.py,*.lua,*.ts,*.vue try | undojoin | | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
            aug END
        ]], false)
    end

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
        hi LspReferenceRead cterm=bold ctermbg=red guibg=#596e7f
        hi LspReferenceText cterm=bold ctermbg=red guibg=#596e7f
        hi LspReferenceWrite cterm=bold ctermbg=red guibg=#596e7f
        augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]], false)
    end
end

local nvim_lsp = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Code actions
capabilities.textDocument.codeAction = {
    dynamicRegistration = true,
    codeActionLiteralSupport = {
        codeActionKind = {
            valueSet = (function()
                local res = vim.tbl_values(vim.lsp.protocol.CodeActionKind)
                table.sort(res)
                return res
            end)()
        }
    }
}

capabilities.textDocument.completion.completionItem.snippetSupport = true;

-- EFM
local prettier_d = {
  formatCommand = 'prettierd ${INPUT}',
  formatStdin = true,
}
local eslint_d = {
    lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"},
    lintIgnoreExitCode = true,
    formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
    formatStdin = true
}
local luaFormat = {
    formatCommand = "luafmt --stdin",
    formatStdin = true
}
local yaml = {
    lintCommand = "yamllint -f parsable -",
    lintStdin = true
}
nvim_lsp.efm.setup {
    init_options = { documentFormatting = true, codeAction = true },
    settings = {
        rootMarkers = {".git/"},
        languages = {
            typtypescript = {eslint_d},
            javascript = {eslint_d},
            typescriptreact = {eslint_d},
            javascriptreact = {eslint_d},
            lua = {luaFormat},
            yaml = {yaml},
            escript = {eslint_d, prettier_d}
        },
    },
    filetypes = {
        "javascript",
        "typescript",
        "typescriptreact",
        "javascriptreact",
        "lua",
        "yaml"
    },
    on_attach = on_attach
}

-- LSPs
local servers = {"pyright", "tsserver", "vimls", "vuels"}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {capabilities = capabilities, on_attach = on_attach}
end

-- Lua LSP
local sumneko_root_path = ""
local sumneko_binary = ""

if vim.fn.has("mac") == 1 then
    sumneko_root_path = "/Users/" .. USER .. "/.config/nvim/lua-language-server"
    sumneko_binary = "/Users/" .. USER ..
                         "/.config/nvim/lua-language-server/bin/macOS/lua-language-server"
elseif vim.fn.has("unix") == 1 then
    sumneko_root_path = "/home/" .. USER .. "/.config/nvim/lua-language-server"
    sumneko_binary = "/home/" .. USER ..
                         "/.config/nvim/lua-language-server/bin/Linux/lua-language-server"
else
    print("Unsupported system for sumneko")
end

-- lua-dev.nvim
local luadev = require("lua-dev").setup({
    library = {vimruntime = true, types = true, plugins = true},
    lspconfig = {
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                    -- Setup your lua path
                    path = vim.split(package.path, ';')
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {'vim'}
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = {
                        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                    }
                }
            }
        }
    }
})
nvim_lsp.sumneko_lua.setup(luadev)

-- symbols-outline.nvim
vim.g.symbols_outline = {
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = false, -- experimental
    position = 'right',
    keymaps = {
        close = "<Esc>",
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "<C-space>",
        rename_symbol = "r",
        code_actions = "a"
    },
    lsp_blacklist = {}
}

-- LSP Enable diagnostics
-- vim.lsp.handlers["textDocument/publishDiagnostics"] =
--     vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--         virtual_text = false,
--         underline = true,
--         signs = true,
--         update_in_insert = false
--     })

-- Send diagnostics to quickfix list
do
    local method = "textDocument/publishDiagnostics"
    local default_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, handler_method, result, client_id, bufnr,
                                        config)
        default_handler(err, handler_method, result, client_id, bufnr, config)
        local diagnostics = vim.lsp.diagnostic.get_all()
        local qflist = {}
        for buffer_nr, diagnostic in pairs(diagnostics) do
            for _, d in ipairs(diagnostic) do
                d.bufnr = buffer_nr
                d.lnum = d.range.start.line + 1
                d.col = d.range.start.character + 1
                d.text = d.message
                table.insert(qflist, d)
            end
        end
        vim.lsp.util.set_qflist(qflist)
    end
end
