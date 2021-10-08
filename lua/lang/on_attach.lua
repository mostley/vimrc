local on_attach = function(client, bufnr)
  require("lsp_signature").on_attach(client)

  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = { noremap = true, silent = true }

  if client.resolved_capabilities.hover then
    buf_set_keymap("n", "K", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
    -- buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  end
  if client.resolved_capabilities.find_references then
    buf_set_keymap("n", "gr", "<cmd>lua require'telescope.builtin'.lsp_references()<CR>", opts)
  end
  if client.resolved_capabilities.goto_definition then
    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  end
  if client.resolved_capabilities.rename then
    -- buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "<leader>rn", "<cmd>lua require'lspsaga.rename'.rename()<CR>", opts)
  end

  buf_set_keymap("n", "<leader>gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  -- buf_set_keymap("n", "gp", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  -- buf_set_keymap("n", "gn", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "gp", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", opts)
  buf_set_keymap("n", "gn", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", opts)
  buf_set_keymap("n", "<leader>law", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<leader>lrw", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<leader>llw", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "<leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  -- buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap("n", "<leader>ld", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  buf_set_keymap("n", "<leader>ll", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
  -- buf_set_keymap("n", "<leader>ac", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  -- buf_set_keymap("n", "<leader>ac", "<cmd>lua require'lspsaga.codeaction'.code_action()<CR>", opts)
  -- buf_set_keymap("v", "<leader>ac", "<cmd>lua require'lspsaga.codeaction'.range_code_action()<CR>", opts)
  buf_set_keymap("n", "<leader>ac", '<cmd>lua require("lsp-fastaction").code_action()<CR>', opts)
  buf_set_keymap("v", "<leader>ac", "<esc><cmd>lua require('lsp-fastaction').range_code_action()<CR>", opts)
  buf_set_keymap("n", "<leader>lss", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", opts)
  buf_set_keymap("n", "gl", "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", opts)

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
        hi LspReferenceRead cterm=bold ctermbg=red guibg=#596e7f
        hi LspReferenceText cterm=bold ctermbg=red guibg=#596e7f
        hi LspReferenceWrite cterm=bold ctermbg=red guibg=#596e7f


        augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]],
      false
    )
  end
end

return on_attach
