require("nvim-lsp-installer").setup {
  automatic_installation = true
}

local lspconfig = require('lspconfig')

lspconfig.sumneko_lua.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = {"vim"},
      },
    },
  },
}
lspconfig.rust_analyzer.setup {}
lspconfig.erlangls.setup {
  root_dir = lspconfig.util.root_pattern('erlang.mk', '.git')
}
lspconfig.elixirls.setup {}
lspconfig.bashls.setup {}
lspconfig.vimls.setup {}
lspconfig.pyright.setup {}
lspconfig.omnisharp.setup {}
