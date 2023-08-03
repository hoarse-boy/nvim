return {
  "chrisgrieser/nvim-spider",
  event = "VeryLazy",
  -- enabled = false, -- disabled plugin
  -- dependencies = {},
  -- init = function() end, -- functions are always executed during startup
  -- opts = function(_, opts) end, -- use this to not overwrite this plugin config (usefull in lazyvim)
  config = function()
    vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
    vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
    vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
    vim.keymap.set({ "n", "o", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-ge" })

    -- default value
    require("spider").setup({
      skipInsignificantPunctuation = true,
    })
  end,
}
