local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'sainnhe/gruvbox-material'

  use {
    "neovim/nvim-lspconfig",
    requires = {
      "williamboman/nvim-lsp-installer",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp"
    },
    config = function()
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

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
    end
  }

  use {
    'mhartington/formatter.nvim',
    config = function()
      require('formatter').setup {
        logging = true,
        log_level = 2,
        filetype = {
          erlang = function()
            return {
                name = "erlfmt",
                exe = "escript",
                args = {
                  "rebar3",
                  "fmt",
                  "-",
                },
                stdin = true
              }
            end,
          python = require("formatter.filetypes.python").black
        }
      }

      local set_keymap = require('util').set_keymap
      set_keymap('n', '<leader>F', ':FormatWrite<CR>')
    end
  }

  use 'editorconfig/editorconfig-vim'

  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'

  use 'cappyzawa/trim.nvim'

  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup({})
    end
  }

  use {
    "ray-x/lsp_signature.nvim",
    config = function()
      require "lsp_signature".setup({})
    end
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}

      local set_keymap = require("util").set_keymap
      set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>")
      set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>")
      set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>")
      set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>")
      set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>")
      set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>")
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-ui-select.nvim'},
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup {
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close
            },
          }
        }
      }

      require("telescope").load_extension("ui-select")

      local set_keymap = require("util").set_keymap
      set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
      set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
      set_keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
      set_keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

      set_keymap("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>")
      set_keymap("n", "<leader>fs", "<cmd>Telescope lsp_workspace_symbols<cr>")
      set_keymap("n", "<leader>fd", "<cmd>Telescope lsp_definitions<cr>")
    end
  }

  use "lukas-reineke/indent-blankline.nvim"

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { "c", "c_sharp", "lua", "rust", "erlang", "elixir", "typescript" },
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = { enable = true },
        textobjects = { enable = true },
      }
    end
  }

  use {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        auto_session_suppress_dirs = {'~/'}
      }
    end
  }

  use {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup {}
    end
  }

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
