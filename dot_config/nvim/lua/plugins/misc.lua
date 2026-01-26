return {
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

  {
    "https://codeberg.org/esensar/nvim-dev-container",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      container_runtime = "podman",
    },
  },

  {
    "Darazaki/indent-o-matic",
    config = true,
    lazy = false,
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

  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        providers = {
          snippets = {
            opts = {
              clipboard_register = "a", -- use the 'a' register for snippets
            },
          },
        },
      },
    },
  },

  -- {
  --   "iamkarasik/sonarqube.nvim",
  --   config = function()
  --     require("sonarqube").setup({
  --     })
  --   end,
  -- },
}
