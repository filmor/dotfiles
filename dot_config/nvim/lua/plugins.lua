return {
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme gruvbox-material]])
    end
  },

  'kazhala/close-buffers.nvim',

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "hrsh7th/vim-vsnip-integ",
      'kosayoda/nvim-lightbulb',
    },
    config = function()
      require('nvim-lightbulb').setup({autocmd = {enabled = true}})
      require('lspconfig').gleam.setup({})
      -- All remaining in lsp.lua
    end
  },
  {
    'mhartington/formatter.nvim',
    keys = {
      {'<leader>F', '<cmd>FormatWrite<cr>', desc = "Format document" }
    },
    lazy = true,
    config = function()
      require("formatter").setup({
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
          python = require("formatter.filetypes.python").ruff,
          rust = function()
            return {
              name = "rustfmt",
              exe = "rustfmt",
              stdin = true,
              args = { "--edition", "2021" }
            }
          end,
          cs = require("formatter.filetypes.cs").dotnetformat,
          json = require("formatter.filetypes.json").jq,
        }
      })
    end
  },
  'editorconfig/editorconfig-vim',

  'vim-airline/vim-airline',
  'vim-airline/vim-airline-themes',

  'cappyzawa/trim.nvim',

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
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

      set_keymap("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>")
      -- set_keymap("n", "<leader>e", "<cmd>NvimTreeFindFile<cr>")
    end
  },

  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require "lsp_signature".setup({})
    end
  },

  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()

      local set_keymap = require("util").set_keymap
      -- Ctrl-/, special keycode
      set_keymap("n", "<C-_>", "gcc")
      set_keymap("i", "<C-_>", "gcc")
      set_keymap("v", "<C-_>", "gc")
    end
  },

  {
      'saecki/crates.nvim',
      tag = 'v0.3.0',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
          require('crates').setup()
      end,
  },

  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {}

      local set_keymap = require("util").set_keymap
      set_keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
      set_keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
      set_keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>")
      set_keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>")
      set_keymap("n", "<leader>xx", "<cmd>TroubleToggle lsp_references<cr>")
    end
  },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = {'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-ui-select.nvim'},
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

      set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
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
      set_keymap("n", "<leader>gf", "<cmd>Telescope git_files<cr>")
    end
  },

  -- use "lukas-reineke/indent-blankline.nvim"

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
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
          "jsonc",
          "just",
          "toml",
          "typescript",
          "yaml",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
          disable = { "yaml", "python" },
        },
        incremental_selection = { enable = true },
        textobjects = { enable = true },
      }
    end
  },

  {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        auto_session_suppress_dirs = {'~/'}
      }
    end
  },

  {
    "akinsho/toggleterm.nvim",

    keys = {
      { "<C-B>", "<cmd>ToggleTerm<cr>", desc = "Terminal" }
    },

    lazy = true,

    opts = {
      open_mapping = "<C-B>",
      shell = "fish",
      direction = "tab"
    }
  },

  {
    'chipsenkbeil/distant.nvim',
    branch = 'v0.3',
    config = function()
        require('distant'):setup()
    end
  },

  {
    'kaarmu/typst.vim',
    ft = 'typst',
    lazy = false,
  },

  {
    'https://codeberg.org/esensar/nvim-dev-container',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      container_runtime = "podman"
    }
  },

  {
    'Julian/lean.nvim',
    event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },

    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
      -- you also will likely want nvim-cmp or some completion engine
    },

    -- see details below for full configuration options
    opts = {
      lsp = {
        on_attach = on_attach,
      },
      mappings = true,
    }
  },

  {
    "nmac427/guess-indent.nvim",
    config = true
  },

  {
    'linux-cultist/venv-selector.nvim',
    branch = "regexp",
    dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
    opts = {
      -- Your options go here
      name = { "venv", ".venv" },
      parents = 0,
      -- auto_refresh = false
    },
    event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { '<leader>vs', '<cmd>VenvSelect<cr>' },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      { '<leader>vc', '<cmd>VenvSelectCached<cr>' },
    },
  },

  {
    "github/copilot.vim"
  },

  {
      'MeanderingProgrammer/render-markdown.nvim',
      -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
      -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
      dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
      ---@module 'render-markdown'
      ---@type render.md.UserConfig
      opts = {},
  }
}
