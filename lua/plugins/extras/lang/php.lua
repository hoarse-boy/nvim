local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local php_keymaps = augroup("php_keymaps", {})
autocmd("Filetype", {
  group = php_keymaps,
  pattern = { "php" },
  callback = function()
    vim.schedule(function()
      vim.keymap.set("n", "<leader>la", ":Laravel artisan<cr>", { buffer = true, desc = "Laravel artisan" })
      vim.keymap.set("n", "<leader>lr", ":Laravel routes<cr>", { buffer = true, desc = "Laravel routes" })
      vim.keymap.set("n", "<leader>lm", ":Laravel related<cr>", { buffer = true, desc = "Laravel related" })

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
        phpactor = {
          cmd = { "phpactor", "language-server" },
          filetypes = { "php" },
          root_dir = require("lspconfig.util").root_pattern("composer.json", ".git"),
        },
      },
    },
  },

  {
    "adalessa/laravel.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "tpope/vim-dotenv",
      "MunifTanjim/nui.nvim",
    },
    cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
    event = "VeryLazy",
    config = true,
  },

  -- Ensure PHP tools are installed
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "phpactor", "phpcbf" })
      -- vim.list_extend(opts.ensure_installed, { "intelephense", "phpactor", "phpcbf" })
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

-- return {
--   {
--     "nvim-treesitter/nvim-treesitter",
--     opts = function(_, opts)
--       vim.list_extend(opts.ensure_installed, {
--         "php",
--       })
--     end,
--   },
--   {
--     "williamboman/mason.nvim",
--     opts = function(_, opts)
--       vim.list_extend(opts.ensure_installed, {
--         "phpactor",
--       })
--     end,
--   },
--   {
--     "neovim/nvim-lspconfig",
--     opts = {
--       servers = {
--         phpactor = {},
--       },
--     },
--   },
--   {
--     "mfussenegger/nvim-dap",
--     optional = true,
--     dependencies = {
--       "williamboman/mason.nvim",
--       opts = function(_, opts)
--         if type(opts.ensure_installed) == "table" then
--           table.insert(opts.ensure_installed, "php-debug-adapter")
--         end
--       end,
--     },
--     opts = function()
--       local dap = require("dap")
--       local path = require("mason-registry").get_package("php-debug-adapter"):get_install_path()
--       dap.adapters.php = {
--         type = "executable",
--         command = "node",
--         args = { path .. "/extension/out/phpDebug.js" },
--       }
--     end,
--   },
-- }
