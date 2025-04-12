return {
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme gruvbox-material]])
    end,
  },

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
