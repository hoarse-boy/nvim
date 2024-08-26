return {
  "chrisgrieser/nvim-spider",
  event = "VeryLazy",
  config = function()
    local printf = require("plugins.util.printf").printf

    vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = printf("Spider-w") })
    vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = printf("Spider-e") })
    vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = printf("Spider-b") })
    vim.keymap.set({ "n", "o", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = printf("Spider-ge") })

    -- default value
    require("spider").setup({
      skipInsignificantPunctuation = false,
    })
  end,
}
