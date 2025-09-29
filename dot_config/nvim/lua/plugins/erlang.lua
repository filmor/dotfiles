return {
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
