require("mason").setup()

local lsp = require("mason-lspconfig")

lsp.setup {
  ensure_installed = {
    "erlangls",
    "lua_ls",
    "rust_analyzer",
    "bashls",
    "vimls",
    "pyright",
    "omnisharp",
  },
  automatic_installation = true
}

local on_attach = function ()
  local set_keymap = require("util").set_keymap
  set_keymap("n", "<leader>A", "<cmd>lua vim.lsp.buf.code_action()<cr>")
  set_keymap("n", "<leader>H", "<cmd>lua vim.lsp.buf.hover()<cr>")
  set_keymap("n", "<leader>R", "<cmd>lua vim.lsp.buf.rename()<cr>")
end

lsp.setup_handlers {
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup { on_attach = on_attach }
  end,
  ["lua_ls"] = function ()
    require("lspconfig").lua_ls.setup {
      on_attach = on_attach,
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
      root_dir = lspconfig.util.root_pattern('erlang.mk', '.git'),
      on_attach = on_attach,
    }
  end
}

local has_words_before = require('util').has_words_before
local cmp = require('cmp')

cmp.setup {
  sources = {
    { name = 'path' },
    { name = 'buffer' },
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'crates' },
  },
  snippet = {
    expand = function(args)
      return vim.fn["vsnip#anonymous"](args.body)
    end
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

    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  },
}

require('cmp_nvim_lsp').default_capabilities()

-- Set updatetime for CursorHold
-- 300ms of no cursor movement to trigger CursorHold
vim.opt.updatetime = 1000

-- Show diagnostic popup on cursor hover
local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
   vim.diagnostic.open_float(nil, { focusable = false })
  end,
  group = diag_float_grp,
})

-- have a fixed column for the diagnostics to appear in
-- this removes the jitter when warnings/errors flow in
vim.wo.signcolumn = "yes"
