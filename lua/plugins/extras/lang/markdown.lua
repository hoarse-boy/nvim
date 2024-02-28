local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- rust keymaps
local markdown_keymaps = augroup("markdown_keymaps", {})
autocmd("Filetype", {
  group = markdown_keymaps,
  pattern = { "md", "markdown" },
  callback = function()
    vim.schedule(function()
      vim.keymap.set("n", "<leader>lt", "<cmd>TOC<cr>", { buffer = true, desc = "Generate Table of Contents" })

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

return {
  -- NOTE: an extention of markdown from lazyvim's
  {
    "richardbizik/nvim-toc",
    event = "VeryLazy",
    config = function()
      require("nvim-toc").setup({})
    end,
  },
}
