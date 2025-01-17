return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        elp = {
          root_dir = function(fname)
            local util = require("lspconfig.util")
            -- Remove rebar.config to find the project root in umbrella projects
            return util.root_pattern("erlang.mk", ".git")(fname)
          end,
        },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        r3fmt = {
          command = "escript",
          args = { "rebar3", "fmt", "-" },
        },
      },
      formatters_by_ft = {
        erlang = { "r3fmt" },
      },
    },
  },
}
