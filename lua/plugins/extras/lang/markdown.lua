local printf = require("plugins.util.printf").printf
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local markdown_keymaps = augroup("markdown_keymaps", {})

return {
  -- NOTE: an extention of markdown from lazyvim's
  {
    "richardbizik/nvim-toc",
    event = "VeryLazy",
    config = function()
      require("nvim-toc").setup({})
    end,
  },

  {
    "folke/which-key.nvim",
    opts = function(_, _)
      autocmd("Filetype", {
        group = markdown_keymaps,
        pattern = { "md", "markdown" }, -- FIX: README.md will have buggy keymaps. find the fix or rename it other than README.md
        callback = function()
          vim.schedule(function()
            vim.keymap.set("n", "<leader>lc", "<cmd>TOC<cr>",
              { buffer = true, desc = printf("Generate Table of Contents") })

            local wk = require("which-key")
            local opts = { prefix = "<leader>", buffer = 0 }
            local mappings = {
              l = {
                name = "+lsp (marksman)",
              },
            }

            wk.register(mappings, opts)
          end)
        end,
      })
    end,
  },
}
