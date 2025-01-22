return {
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme gruvbox-material]])
    end,
  },

  -- {
  --   "neovim/nvim-lspconfig",
  --   dependencies = {
  --     "williamboman/mason.nvim",
  --     "williamboman/mason-lspconfig.nvim",
  --     "hrsh7th/nvim-cmp",
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-vsnip",
  --     "hrsh7th/vim-vsnip",
  --     "hrsh7th/vim-vsnip-integ",
  --     "kosayoda/nvim-lightbulb",
  --   },
  --   config = function()
  --     require("nvim-lightbulb").setup({ autocmd = { enabled = true } })
  --     require("lspconfig").gleam.setup({})
  --     -- All remaining in lsp.lua
  --   end,
  -- },
  -- {
  --   "mhartington/formatter.nvim",
  --   keys = {
  --     { "<leader>F", "<cmd>FormatWrite<cr>", desc = "Format document" },
  --   },
  --   lazy = true,
  --   config = function()
  --     require("formatter").setup({
  --       logging = true,
  --       log_level = 2,
  --       filetype = {
  --         erlang = function()
  --           return {
  --             name = "erlfmt",
  --             exe = "escript",
  --             args = {
  --               "rebar3",
  --               "fmt",
  --               "-",
  --             },
  --             stdin = true,
  --           }
  --         end,
  --         elixir = require("formatter.filetypes.elixir").mixformat,
  --         python = require("formatter.filetypes.python").ruff,
  --         rust = function()
  --           return {
  --             name = "rustfmt",
  --             exe = "rustfmt",
  --             stdin = true,
  --             args = { "--edition", "2021" },
  --           }
  --         end,
  --         cs = require("formatter.filetypes.cs").dotnetformat,
  --         json = require("formatter.filetypes.json").jq,
  --       },
  --     })
  --   end,
  -- },

  -- {
  --   "ray-x/lsp_signature.nvim",
  --   config = function()
  --     require("lsp_signature").setup({})
  --   end,
  -- },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "c",
        "c_sharp",
        "lua",
        "rust",
        "python",
        "erlang",
        "elixir",
        "heex",
        "html",
        "eex",
        "json",
        "jsonc",
        "just",
        "toml",
        "typescript",
        "yaml",
      },

      indent = {
        enable = true,
        disable = { "yaml", "python" },
      },
    },
  },

  {
    "akinsho/toggleterm.nvim",

    keys = {
      { "<C-B>", "<cmd>ToggleTerm<cr>", desc = "Terminal" },
    },

    lazy = true,

    opts = {
      open_mapping = "<C-B>",
      shell = "fish",
      direction = "tab",
    },
  },

  -- {
  --   "kaarmu/typst.vim",
  --   ft = "typst",
  --   lazy = false,
  -- },

  {
    "https://codeberg.org/esensar/nvim-dev-container",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      container_runtime = "podman",
    },
  },

  {
    "nmac427/guess-indent.nvim",
    config = true,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
}
