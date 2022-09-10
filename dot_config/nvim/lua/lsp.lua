require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = {
    "erlangls",
    "sumneko_lua",
    "rust_analyzer",
    "bashls",
    "vimls",
    "pyright",
    "omnisharp",
  },
  automatic_installation = true
}
require("mason-lspconfig").setup_handlers {
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end,
  ["sumneko_lua"] = function ()
    require("lspconfig").sumneko_lua.setup {
      settings = {
        Lua = {
          diagnostics = {
            globals = {"vim"},
          },
        },
      },
    }
  end,
  ["erlangls"] = function ()
    local lspconfig = require("lspconfig")
    lspconfig.erlangls.setup {
      root_dir = lspconfig.util.root_pattern('erlang.mk', '.git')
    }
  end
}
