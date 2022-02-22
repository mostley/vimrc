local M = {}

local packer_bootstrap = false

local function packer_init()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    })
    vim.cmd([[packadd packer.nvim]])
  end
  vim.cmd("autocmd BufWritePost plugins.lua source <afile> | PackerCompile")
end

packer_init()

function M.setup()
  local conf = {
    -- log = { level = 'trace' },
    max_jobs = 20,
    compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "rounded" })
      end,
    },
  }

  local function plugins(use)
    -- use({ "lewis6991/impatient.nvim" })

    use({ "wbthomason/packer.nvim" })

    -- Config
    use({
      "dstein64/vim-startuptime",
      cmd = "StartupTime",
      config = [[vim.g.startuptime_tries = 10]],
    })

    -- Development
    use({ "tpope/vim-dispatch" })
    use({ "tpope/vim-fugitive" })
    use({ "tpope/vim-surround" })
    -- use({ "tpope/vim-commentary" })
    use({
      "numToStr/Comment.nvim",
      keys = { "gc", "gcc", "gbc" },
      config = function()
        require("Comment").setup()
      end,
    })
    use({ "tpope/vim-sleuth" })
    use({ "tpope/vim-repeat" })
    use({ "tpope/vim-abolish" })
    use({
      "mg979/vim-visual-multi",
      branch = "master",
    })
    use({ "wellle/targets.vim" })
    use({ "easymotion/vim-easymotion" })
    use({
      "lewis6991/gitsigns.nvim",
      config = function()
        require("config.gitsigns").setup()
      end,
    })
    -- use({ "akinsho/bufferline.nvim" })
    use({ "unblevable/quick-scope" })
    use({
      "folke/which-key.nvim",
      config = function()
        require("config.whichkey").setup()
      end,
    })
    use({
      "kevinhwang91/rnvimr",
      config = function()
        vim.g.rnvimr_hide_gitignore = 1
        vim.g.rnvimr_enable_bw = 1
      end,
    })
    use({ "tikhomirov/vim-glsl" })
    use({ "stevearc/vim-arduino" })

    -- Color scheme
    use({ "norcalli/nvim-colorizer.lua" })
    use({ "siduck76/nvim-base16.lua" })
    use({
      "kyazdani42/nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup({ default = true })
        require("config.file-icons").setup()
      end,
    })
    use({ "lukas-reineke/indent-blankline.nvim" })
    use({ "gruvbox-community/gruvbox" })
    use({ "tomasr/molokai" })
    use({
      "karb94/neoscroll.nvim",
      config = function()
        require("config.colorscheme").setup()
      end,
    })

    use({ "glacambre/firenvim" })

    -- Testing
    use({
      "rcarriga/vim-ultest",
      config = function()
        require("config.ultest").setup()
      end,
      run = ":UpdateRemotePlugins",
      requires = { "vim-test/vim-test" },
    })

    -- Telescope
    use({ "nvim-lua/plenary.nvim" })
    use({ "nvim-lua/popup.nvim" })
    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-telescope/telescope-file-browser.nvim",
        "xiyaowong/telescope-emoji.nvim",
        "fhill2/telescope-ultisnips.nvim",
        "nvim-telescope/telescope-symbols.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        { "nvim-telescope/telescope-project.nvim" },
        {
          "nvim-telescope/telescope-frecency.nvim",
          requires = { "tami5/sql.nvim" },
        },
        {
          "nvim-telescope/telescope-vimspector.nvim",
          event = "BufWinEnter",
        },
        { "nvim-telescope/telescope-dap.nvim" },
      },
      config = function()
        require("config.telescope").setup()
      end,
    })

    -- LSP config
    use({ "williamboman/nvim-lsp-installer" })
    use({ "jose-elias-alvarez/null-ls.nvim" })
    use({
      "neovim/nvim-lspconfig",
      as = "nvim-lspconfig",
      after = "nvim-treesitter",
      -- opt = true,
      config = function()
        require("config.lsp").setup()
        -- require("config.dap").setup()
      end,
    })

    -- Completion
    use({
      "hrsh7th/nvim-cmp",
      after = "nvim-treesitter",
      -- opt = true,
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "quangnguyen30192/cmp-nvim-ultisnips",
        "hrsh7th/cmp-nvim-lua",
        "octaltree/cmp-look",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-calc",
        "f3fora/cmp-spell",
        "hrsh7th/cmp-emoji",
        "ray-x/cmp-treesitter",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp-document-symbol",
      },
      config = function()
        require("config.cmp").setup()
      end,
    })
    -- use({
    --   "hrsh7th/nvim-compe",
    --   requires = {
    --     { "andersevenrud/compe-tmux", branch = "compe" },
    --   },
    -- })

    -- Better LSP experience
    -- use({ "glepnir/lspsaga.nvim" })
    -- use({ "al3xfischer/lspsaga.nvim" })
    use({
      "windwp/lsp-fastaction.nvim",
      config = function()
        require("config.fastaction").setup()
      end,
    })
    use({
      "onsails/lspkind-nvim",
      config = function()
        require("lspkind").init()
      end,
    })
    use({ "p00f/nvim-ts-rainbow" })
    use({ "ray-x/lsp_signature.nvim" })
    use({ "szw/vim-maximizer" })
    -- use {'dyng/ctrlsfjvim'}
    -- use {'dbeniamine/cheat.sh-vim'}
    use({
      "pechorin/any-jump.vim",
      config = function()
        vim.g.any_jump_disable_default_keybindings = 1
      end,
    })
    use({ "kevinhwang91/nvim-bqf", ft = "qf" })
    use({
      "junegunn/fzf",
      run = function()
        vim.fn["fzf#install"]()
      end,
    })
    use({
      "folke/trouble.nvim",
      event = "VimEnter",
      cmd = { "TroubleToggle", "Trouble" },
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup({})
      end,
    })
    use({
      "folke/todo-comments.nvim",
      cmd = { "TodoTrouble", "TodoTelescope" },
      config = function()
        require("todo-comments").setup({})
      end,
    })
    use({ "folke/lsp-colors.nvim" })
    use({
      "SirVer/ultisnips",
      requires = { { "honza/vim-snippets", rtp = "." } },
      config = function()
        vim.g.UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
        vim.g.UltiSnipsJumpForwardTrigger = "<Plug>(ultisnips_jump_forward)"
        vim.g.UltiSnipsJumpBackwardTrigger = "<Plug>(ultisnips_jump_backward)"
        vim.g.UltiSnipsListSnippets = "<c-x><c-s>"
        vim.g.UltiSnipsRemoveSelectModeMappings = 0
      end,
    })

    -- Lua development
    use({ "folke/lua-dev.nvim" })
    use({ "simrat39/symbols-outline.nvim" })

    -- Better syntax
    use({
      "nvim-treesitter/nvim-treesitter",
      requires = {
        "jose-elias-alvarez/nvim-lsp-ts-utils",
        "JoosepAlviste/nvim-ts-context-commentstring",
        {
          "nvim-treesitter/playground",
          cmd = "TSHighlightCapturesUnderCursor",
        },
        "nvim-treesitter/nvim-treesitter-refactor",
        {
          "nvim-treesitter/completion-treesitter",
          run = function()
            vim.cmd([[TSUpdate]])
          end,
        },
        "nvim-treesitter/nvim-treesitter-textobjects",
        {
          "windwp/nvim-ts-autotag",
          config = function()
            require("nvim-ts-autotag").setup({ enable = true })
          end,
        },
        {
          "romgrk/nvim-treesitter-context",
          config = function()
            require("treesitter-context.config").setup({ enable = true })
          end,
        },
        -- {
        --  "mfussenegger/nvim-ts-hint-textobject",
        --config = function()
        --vim.cmd [[omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>]]
        --vim.cmd [[vnoremap <silent> m :lua require('tsht').nodes()<CR>]]
        --end,
        --},
      },
      config = function()
        require("config.treesitter").setup()
      end,
    })
    --use("~/projects/private/treesitter-boolean.nvim")

    -- Dashboard
    use({
      "glepnir/dashboard-nvim",
      config = function()
        require("config.dashboard").setup()
      end,
    })

    -- Status line
    use({
      "NTBBloodbath/galaxyline.nvim", -- instead of gleipnir/galaxyline.nvim until if's fixed
      branch = "main",
      config = function()
        require("statusline")
      end,
    })

    -- Debugging
    use({ "puremourning/vimspector" })

    -- DAP
    use({ "mfussenegger/nvim-dap" })
    use({ "mfussenegger/nvim-dap-python" }) -- Python
    use({ "theHamsta/nvim-dap-virtual-text" })
    use({ "rcarriga/nvim-dap-ui" })
    use({ "Pocco81/DAPInstall.nvim" })

    -- Project
    use({ "airblade/vim-rooter" })

    use({
      "ThePrimeagen/refactoring.nvim",
      requires = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-treesitter/nvim-treesitter" },
      },
      config = function()
        require("config.refactoring").setup()
      end,
    })

    -- Rust
    use({ "rust-lang/rust.vim", event = "VimEnter" })
    use({
      "simrat39/rust-tools.nvim",
      after = "nvim-lspconfig",
      config = function()
        require("rust-tools").setup({})
      end,
    })
    use({
      "Saecki/crates.nvim",
      event = { "BufRead Cargo.toml" },
      config = function()
        require("crates").setup()
      end,
    })

    use({ "b0o/schemastore.nvim" })
    use({
      "ThePrimeagen/harpoon",
      module = "harpoon",
      config = function()
        require("config.harpoon").setup()
      end,
    })

    use({
      "iamcco/markdown-preview.nvim",
      run = "cd app && yarn install",
      ft = "markdown",
      cmd = { "MarkdownPreview" },
    })
    use({
      "plasticboy/vim-markdown",
      event = "VimEnter",
      ft = "markdown",
      requires = { "godlygeek/tabular" },
    })
    use({
      "vuki656/package-info.nvim",
      event = "VimEnter",
      requires = "MunifTanjim/nui.nvim",
      config = function()
        require("package-info").setup()
      end,
    })
    use({
      "rcarriga/nvim-notify",
      config = function()
        vim.notify = require("notify")
      end,
    })

    -- use({ "floobits/floobits-neovim" })
    use({ "github/copilot.vim" })

    if packer_bootstrap then
      print("Setting up Neovim. Restart required after installation!")
      require("packer").sync()
    end
  end

  -- pcall(require, "impatient")
  pcall(require, "packer_compiled")
  require("packer").init(conf)
  require("packer").startup(plugins)
end

return M
