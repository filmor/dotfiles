return {
  {
    "nvim-treesitter/nvim-treesitter",

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
}
