return {
  "theprimeagen/harpoon",
  event = "VeryLazy",
  keys = {
    -- stylua: ignore
    { "<leader>hm", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Mark a File" },
    { "<leader>hT", ":Telescope harpoon marks<cr>", desc = "Open Telescope Harpoon" },
    -- stylua: ignore
    { "<leader>ht", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Toggle Quick Menu (use to delete mark only)" }, -- NOTE: also for some golang repo which has many go.mod in a single git file it will not be able to show the marked files
    -- { "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<cr>", desc = "Go to next" },
    -- { "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", desc = "Go to previous" },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    local keymaps = {
      mode = { "n" },
      ["<leader>h"] = { name = "+harpoon" },
    }
    wk.register(keymaps, opts)

    require("harpoon").setup({
      -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
      save_on_toggle = false,

      -- saves the harpoon file upon every change. disabling is unrecommended.
      save_on_change = true,

      -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
      enter_on_sendcmd = false,

      -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
      tmux_autoclose_windows = false,

      -- filetypes that you want to prevent from adding to the harpoon list menu.
      excluded_filetypes = { "harpoon" },

      -- set marks specific to each git branch inside git repository
      mark_branch = false,

      -- enable tabline with harpoon marks
      tabline = false,
      tabline_prefix = "   ",
      tabline_suffix = "   ",
    })
    require("telescope").load_extension("harpoon")
  end,
}
