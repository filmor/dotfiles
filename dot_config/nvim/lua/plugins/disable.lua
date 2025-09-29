return {
  {
    "tpope/mini.pairs",
    enabled = false
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        elixirls = {
          mason = false,
          enabled = false,
        },
      },
    },
  }
}
