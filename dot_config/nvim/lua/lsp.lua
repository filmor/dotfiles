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

local set_keymap = require("util").set_keymap
local has_words_before = require('util').has_words_before
local cmp = require('cmp')

cmp.setup {
  sources = {
    { name = 'nvim_lsp' }
  },
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),

    ['<Tab>'] = function(fallback)
      if not cmp.select_next_item() then
        if vim.bo.buftype ~= 'prompt' and has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end
    end,

    ['<S-Tab>'] = function(fallback)
      if not cmp.select_prev_item() then
        if vim.bo.buftype ~= 'prompt' and has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end
    end,
  },
}

require('cmp_nvim_lsp').default_capabilities()

set_keymap("n", "<leader>ll", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>")
