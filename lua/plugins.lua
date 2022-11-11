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
    print("installed packer")
  end

  vim.cmd([[packadd packer.nvim]])
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
    use({ "tpope/vim-commentary" })
    -- use({
    -- "numToStr/Comment.nvim",
    -- keys = { "gcc", "gbc" },
    -- })
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
      tag = "release",
      requires = { "nvim-lua/plenary.nvim" },
    })
    use({ "unblevable/quick-scope" })
    use({ "mrjones2014/legendary.nvim" })
    use({ "folke/which-key.nvim" })
    use({ "kevinhwang91/rnvimr" })
    use({
      "kyazdani42/nvim-tree.lua",
      requires = {
        "kyazdani42/nvim-web-devicons", -- optional, for file icon
      },
    })
    use({ "tikhomirov/vim-glsl" })
    use({ "stevearc/vim-arduino" })

    -- Color scheme
    use({ "norcalli/nvim-colorizer.lua" })
    use({ "siduck76/nvim-base16.lua" })
    use({
      "kyazdani42/nvim-web-devicons",
      opt = true,
      config = function()
        require("nvim-web-devicons").setup({ default = true })
        require("config.file-icons").setup()
      end,
    })
    use({ "lukas-reineke/indent-blankline.nvim" })
    use({ "stevearc/dressing.nvim" })
    use({ "gruvbox-community/gruvbox" })
    use({ "tomasr/molokai" })
    use({ "karb94/neoscroll.nvim" })
    use({ "j-hui/fidget.nvim" })

    use({ "glacambre/firenvim" })

    -- Terminal emulator
    -- ---------------------
    use({ "akinsho/toggleterm.nvim" })

    -- Testing
    use({
      "rcarriga/vim-ultest",
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
        { "nvim-telescope/telescope-fzy-native.nvim", run = "make" },
        { "ibhagwan/fzf-lua", requires = { "kyazdani42/nvim-web-devicons" } },
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
        { "nvim-telescope/telescope-ui-select.nvim" },
      },
    })
    use({ "nvim-telescope/telescope-ui-select.nvim" })

    -- LSP config
    use({ "jose-elias-alvarez/null-ls.nvim" })

    use({ "williamboman/mason.nvim" })
    use({ "williamboman/mason-lspconfig.nvim" })
    use({
      "neovim/nvim-lspconfig",
      as = "nvim-lspconfig",
      after = "nvim-treesitter",
      -- opt = true,
    })
    use({ "RRethy/vim-illuminate" })
    use({
      "stevearc/aerial.nvim",
      requires = {
        "onsails/lspkind-nvim",
      },
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
    use({ "windwp/lsp-fastaction.nvim" })
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
    })
    --use("~/projects/private/treesitter-boolean.nvim")

    -- Dashboard
    use({
      "goolord/alpha-nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
    })

    -- Status line
    use({
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
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
    })

    -- Rust
    -- use({ "rust-lang/rust.vim", event = "VimEnter" })
    use({
      "simrat39/rust-tools.nvim",
      after = "nvim-lspconfig",
    })
    use({
      "Saecki/crates.nvim",
      tag = "v0.2.1",
      requires = { "nvim-lua/plenary.nvim" },
      event = { "BufRead Cargo.toml" },
      config = function()
        require("crates").setup()
      end,
    })

    use({ "b0o/schemastore.nvim" })
    use({
      "ThePrimeagen/harpoon",
      module = "harpoon",
    })

    use({
      "plasticboy/vim-markdown",
      event = "VimEnter",
      ft = "markdown",
      requires = { "godlygeek/tabular" },
    })
    use({ "ellisonleao/glow.nvim" })
    use({
      "vuki656/package-info.nvim",
      event = "VimEnter",
      requires = "MunifTanjim/nui.nvim",
      config = function()
        require("package-info").setup({ package_manager = "npm" })
      end,
    })
    use({
      "rcarriga/nvim-notify",
      config = function()
        vim.notify = require("notify")
      end,
    })
    use({ "jbyuki/venn.nvim" })

    -- use({ "floobits/floobits-neovim" })
    use({ "github/copilot.vim" })

    if packer_bootstrap then
      print("Setting up Neovim. Restart required after installation!")
      require("packer").sync()
    end
  end

  pcall(require, "packer_compiled")
  require("packer").init(conf)
  require("packer").startup(plugins)
end

return M
