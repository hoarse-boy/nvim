local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local printf = require("plugins.util.printf").printf

local php_keymaps = augroup("php_keymaps", {})

-- NOTE: depracated. use lazyvim php instead.
-- maybe the tree-sitter-blade causes the performance issue?
return {
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   config = function(_, opts)
  --     -- NOTE: treesitter blade is not supported yet. so add the parser manually like below and install it.
  --     -- see this link https://github.com/EmranMR/tree-sitter-blade/discussions/19#discussion-5400675 for details.
  --     local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

  --     parser_config.blade = {
  --       install_info = {
  --         url = "https://github.com/EmranMR/tree-sitter-blade",
  --         files = { "src/parser.c" },
  --         branch = "main",
  --       },
  --       filetype = "blade",
  --     }

  --     vim.filetype.add({
  --       pattern = {
  --         [".*%.blade%.php"] = "blade",
  --       },
  --     })

  --     require("nvim-treesitter.configs").setup(opts)
  --   end,
  -- },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          cmd = { "intelephense", "--stdio" }, -- NOTE: intelephense is better than phpactor to display the laravel class function?
          filetypes = { "php", "blade" },
          root_dir = require("lspconfig.util").root_pattern("composer.json", ".git"),
        },
        -- phpactor = {
        --   cmd = { "phpactor", "language-server" },
        --   filetypes = { "php" },
        --   root_dir = require("lspconfig.util").root_pattern("composer.json", ".git"),
        -- },
      },
    },
  },

  {
    "folke/which-key.nvim",
    opts = function(_, _)
      autocmd("Filetype", {
        group = php_keymaps,
        pattern = { "php" },
        callback = function()
          vim.schedule(function()
            vim.keymap.set("n", "<leader>la", ":Laravel artisan<cr>", { buffer = true, desc = printf("Laravel artisan") })
            vim.keymap.set("n", "<leader>lr", ":Laravel routes<cr>", { buffer = true, desc = printf("Laravel routes") })
            vim.keymap.set("n", "<leader>lm", ":Laravel related<cr>", { buffer = true, desc = printf("Laravel related") })

            local wk = require("which-key")
            local opts = { prefix = "<leader>", buffer = 0 }
            local mappings = {
              l = {
                name = "+lsp (intelephense)",
              },
            }

            wk.register(mappings, opts)
          end)
        end,
      })
    end,
  },

  -- plugin to help with laravel project. this is way better than nvim version as it doesnt call the command in the notes below that causes timeout. thus rendering the plugin useless.
  -- {
  --   "noahfrederick/vim-laravel",
  --   event = "LazyFile",
  --   dependencies = {
  --     -- dependencies are needed to run the command from vim-laravel. TODO: add the most usefull command as keymaps above.
  --     -- NOTE: it uses vim code and causes lspconfig nvim to forced to reload first at startup? causing performance issue.
  --     "tpope/vim-dispatch",
  --     "tpope/vim-projectionist",
  --     "noahfrederick/vim-composer",
  --   },
  -- },

  -- Ensure PHP tools are installed
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      -- vim.list_extend(opts.ensure_installed, { "phpactor", "phpcbf" })
      vim.list_extend(opts.ensure_installed, { "intelephense", "phpcbf" })
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    optional = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "phpcbf", "blade-formatter" })
        end,
      },
    },
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.formatting.phpcbf,
        nls.builtins.formatting.blade_formatter,
      })
    end,
  },

  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "php-debug-adapter" })
        end,
      },
    },
  },

  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "olimorris/neotest-phpunit",
    },
    opts = {
      adapters = {
        ["neotest-phpunit"] = {},
      },
    },
  },

  -- NOTE:
  -- adalessa/laravel.nvim
  -- phpactor.nvim
  -- and phpactor
  -- will all calls planery job.lua that will call the command php artisan route:list -v which if the project is too big will be more than 5s and return an error instead.
  -- use intelephense instead for now.

  -- {
  --   "gbprod/phpactor.nvim",
  --   event = "VeryLazy",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim", -- required to update phpactor
  --   },
  --   -- build = function()
  --   --   require("phpactor.handler.update")()
  --   -- end,
  --   opts = {
  --     install = {
  --       path = vim.fn.stdpath("data") .. "/mason/phpactor",
  --       bin = vim.fn.stdpath("data") .. "/mason/bin/phpactor",
  --     },
  --   },
  --   -- config = function()
  --   --   require("phpactor").setup({
  --   --     -- your configuration comes here
  --   --     -- or leave it empty to use the default settings
  --   --     -- refer to the configuration section below
  --   --   })
  --   -- end,
  -- },

  -- {
  --   "adalessa/laravel.nvim",
  --   dependencies = {
  --     "nvim-telescope/telescope.nvim",
  --     "tpope/vim-dotenv",
  --     "MunifTanjim/nui.nvim",
  --   },
  --   cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
  --   event = "VeryLazy",
  --   config = true,
  -- },
}
