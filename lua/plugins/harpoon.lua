return {
  "theprimeagen/harpoon",
  event = "VeryLazy",
  keys = {
    -- stylua: ignore
    { "<leader>hm", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Mark for Harpoon" },
    { "<leader>ht", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Toggle Quick Menu" },
    { "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<cr>", desc = "Go to next" },
    { "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", desc = "Go to previous" },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    local keymaps = {
      mode = { "n" },
      ["<leader>h"] = { name = "+harpoon" },
    }
    wk.register(keymaps, opts)

    require("harpoon").setup()
  end,
}
