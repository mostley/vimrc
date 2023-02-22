-- Completion
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "onsails/lspkind-nvim",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "quangnguyen30192/cmp-nvim-ultisnips",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "f3fora/cmp-spell",
    "hrsh7th/cmp-emoji",
    "ray-x/cmp-treesitter",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp-document-symbol",
    "petertriho/cmp-git",
  },
  config = function()
    local cmp_status_ok, cmp = pcall(require, "cmp")
    if not cmp_status_ok then
      vim.notify("failed to load cmp", vim.log.levels.ERROR)
      return
    end

    local has_any_words_before = function()
      if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
        return false
      end
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local press = function(key)
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", true)
    end

    -- local feedkey = function(key, mode)
    --   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
    -- end

    local t = function(str)
      return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

    cmp.setup({
      snipet = {
        expand = function(args)
          -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
          vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
      },
      formatting = {
        format = require("lspkind").cmp_format({
          with_text = true,
          menu = {
            nvim_lsp = "[LSP]",
            buffer = "[Buffer]",
            nvim_lua = "[Lua]",
            ultisnips = "[UltiSnips]",
            vsnip = "[vSnip]",
            git = "[Git]",
            treesitter = "[treesitter]",
            path = "[Path]",
            spell = "[Spell]",
            calc = "[Calc]",
            emoji = "[Emoji]",
            neorg = "[Neorg]",
          },
        }),
      },
      mapping = {
        ["<C-n>"] = cmp.mapping({
          c = function()
            if cmp.visible() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            else
              vim.api.nvim_feedkeys(t("<Down>"), "n", true)
            end
          end,
          i = function(fallback)
            if cmp.visible() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            else
              fallback()
            end
          end,
        }),
        ["<C-p>"] = cmp.mapping({
          c = function()
            if cmp.visible() then
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
            else
              vim.api.nvim_feedkeys(t("<Up>"), "n", true)
            end
          end,
          i = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
            else
              fallback()
            end
          end,
        }),
        ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs( -4), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-y>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
        ["<C-Space>"] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() then
              if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
                return press("<C-R>=UltiSnips#ExpandSnippet()<CR>")
              end
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace })
            elseif has_any_words_before() then
              press("<Space>")
            else
              fallback()
            end
          end,
          c = function()
            if cmp.visible() then
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace })
            else
              vim.api.nvim_feedkeys(t("<Down>"), "n", true)
            end
          end,
        }),
      },
      sources = {
        { name = "nvim_lsp",   max_item_count = 10 },
        { name = "nvim_lua",   max_item_count = 5 },
        { name = "ultisnips",  max_item_count = 5 },
        { name = "buffer",     keyword_length = 5, max_item_count = 5 },
        { name = "path" },
        { name = "treesitter", max_item_count = 10 },
        { name = "emoji" },
        { name = "spell" },
        { name = "git" },
      },
      completion = { completeopt = "menu,menuone,noselect,noinsert", keyword_length = 1 },
    })

    -- Use cmdline & path source for ':'.
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path", max_item_count = 5 },
      }, {
        { name = "cmdline", max_item_count = 8 },
      }),
    })

    -- lsp_document_symbols
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "nvim_lsp_document_symbol", max_item_count = 8, keyword_length = 3 },
      }, {
        { name = "buffer", max_item_count = 5, keyword_length = 5 },
      }),
    })

    require("cmp_git").setup()
    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "git" },
      }, {
        { name = "buffer" },
      }),
    })
  end,
}
