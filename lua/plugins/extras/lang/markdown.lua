return {
  -- NOTE: an extention of markdown from lazyvim's
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {
          keys = {
            { "<leader>lt", "<cmd>TOC<cr>", desc = "generate table of contents" },
          },
        },
      },
    },
  },

  {
    "richardbizik/nvim-toc",
    event = "VeryLazy",
    config = function()
      require("lazyvim.util").lsp.on_attach(function(client, buffer)
        if client.name == "marksman" then
          local wk = require("which-key")
          local opts = {
            mode = "n", -- NORMAL mode
            -- prefix: use "<leader>f" for example for mapping everything related to finding files
            -- the prefix is prepended to every mapping part of `mappings`
            prefix = "<leader>",
            -- NOTE: use buffer from lazyvim.util to only shows keymaps on the targetted buffer
            buffer = buffer, -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true, -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = false, -- use `nowait` when creating keymaps
            expr = false, -- use `expr` when creating keymaps
          }

          local mappings = {
            l = {
              name = "+lsp (marksman)",
            },
          }

          wk.register(mappings, opts)
        end
      end)

      require("nvim-toc").setup({})
    end,
  },
}
