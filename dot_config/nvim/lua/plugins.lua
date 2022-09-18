local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local PACKER_BOOTSTRAP = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'kazhala/close-buffers.nvim'

  use 'sainnhe/gruvbox-material'

  use {
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    config = function()
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

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

      set_keymap("n", "<leader>ll", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>")
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
          elixir = require("formatter.filetypes.elixir").mixformat,
          python = require("formatter.filetypes.python").black,
          rust = require("formatter.filetypes.rust").rustfmt,
          cs = require("formatter.filetypes.cs").dotnetformat,
          json = require("formatter.filetypes.json").jq,
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
      require('nvim-tree').setup {
        hijack_cursor = true,
        view = {
          float = {
            -- enable = true,
            open_win_config = {
              row = 4,
              col = 4
            }
          },
        },
        diagnostics = {
          enable = true
        },
        renderer = {
          group_empty = true,
          highlight_opened_files = "icon",
        },
        filters = {
          dotfiles = true,
        },
      }

      local set_keymap = require("util").set_keymap

      -- set_keymap("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>")
      set_keymap("n", "<leader>e", "<cmd>NvimTreeFindFile<cr>")
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
      set_keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
      set_keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
      set_keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>")
      set_keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>")
      set_keymap("n", "<leader>xx", "<cmd>TroubleToggle lsp_references<cr>")
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
      set_keymap("n", "<leader>h", "<cmd>Telescope keymaps<cr>")

      set_keymap("n", "<leader>fd", "<cmd>Telescope find_files<cr>")
      set_keymap("n", "<leader>ff", "<cmd>Telescope git_files<cr>")
      set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
      set_keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
      set_keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

      set_keymap("n", "<leader>lr", "<cmd>Telescope lsp_references<cr>")
      set_keymap("n", "<leader>lw", "<cmd>Telescope lsp_workspace_symbols<cr>")
      set_keymap("n", "<leader>ld", "<cmd>Telescope lsp_definitions<cr>")
      set_keymap("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>")

      set_keymap("n", "<leader>ts", "<cmd>Telescope treesitter<cr>")

      set_keymap("n", "<leader>gc", "<cmd>Telescope git_commits<cr>")
      set_keymap("n", "<leader>gb", "<cmd>Telescope git_bcommits<cr>")
      set_keymap("n", "<leader>gt", "<cmd>Telescope git_branches<cr>")
      set_keymap("n", "<leader>gs", "<cmd>Telescope git_status<cr>")
    end
  }

  -- use "lukas-reineke/indent-blankline.nvim"

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
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
          "toml",
          "typescript"
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = true,
        },
        indent = { disable = true },
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

  -- use {
  --   'j-hui/fidget.nvim',
  --   config = function()
  --     require('fidget').setup {}
  --   end
  -- }

  use {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup {
        open_mapping = "<C-]>",
        shell = "fish",
        direction = "tab"
      }
    end
  }

  use {
    "mhanberg/elixir.nvim",
    requires = {"neovim/nvim-lspconfig", "nvim-lua/plenary.nvim"},
    config = function()
      require("elixir").setup {
      }
    end
  }

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
