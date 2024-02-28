local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local php_keymaps = augroup("php_keymaps", {})
autocmd("Filetype", {
  group = php_keymaps,
  pattern = { "php" },
  callback = function()
    vim.schedule(function()
      -- vim.keymap.set("n", "<leader>la", ":Laravel artisan<cr>", { buffer = true, desc = "Laravel artisan" })
      -- vim.keymap.set("n", "<leader>lr", ":Laravel routes<cr>", { buffer = true, desc = "Laravel routes" })
      -- vim.keymap.set("n", "<leader>lm", ":Laravel related<cr>", { buffer = true, desc = "Laravel related" })

      local wk = require("which-key")
      local opts = { prefix = "<leader>", buffer = 0 }
      local mappings = {
        l = {
          name = "+lsp (phpactor)",
        },
      }

      wk.register(mappings, opts)
    end)
  end,
})

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "php",
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          cmd = { "intelephense", "--stdio" }, -- NOTE: intelephense is better than phpactor to display the laravel class function?
          filetypes = { "php" },
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

  -- plugin to help with laravel project. this is way better than nvim version as it doesnt call the command in the notes below that causes timeout. thus rendering the plugin useless.
  {
    "noahfrederick/vim-laravel",
    dependencies = {
      -- dependencies are needed to run the command from vim-laravel. TODO: add the most usefull command as keymaps above.
      "tpope/vim-dispatch",
      "tpope/vim-projectionist",
      "noahfrederick/vim-composer",
    },
    event = "VeryLazy",
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
          vim.list_extend(opts.ensure_installed, { "phpcbf" })
        end,
      },
    },
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.formatting.phpcbf,
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        php = { "phpcbf" },
      },
    },
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
}
