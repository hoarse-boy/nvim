local printf = require("plugins.util.printf").printf

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  tag = "v1.4.3", -- NOTE: reverted to this tag to make +prefix bug in whichkey to show correct defaults name.
  opts = {
    plugins = { spelling = true },
    defaults = {
      mode = { "n", "v" },
      ["g"] = { name = "+goto" },
      ["gs"] = { name = "+surround" },
      ["]"] = { name = "+next" },
      ["["] = { name = "+prev" },
      ["<leader><tab>"] = { name = "+tabs" },
      ["<leader>b"] = { name = "+buffer" },
      ["<leader>c"] = { name = "+code" },
      ["<leader>f"] = { name = "+file/find" },
      ["<leader>g"] = { name = "+git" },
      ["<leader>gh"] = { name = "+hunks" }, -- NOTE: not working? tag 1.5 above which has the auto remove defaults when the child keymap is empty causes a bug where the name will be +prefix.
      ["<leader>q"] = { name = "+quit/session" },
      ["<leader>s"] = { name = "+search" },
      ["<leader>u"] = { name = "+ui" },
      ["<leader>w"] = { name = "+windows" },
      ["<leader>x"] = { name = "+diagnostics/quickfix" },
      ["<leader>d"] = { name = "+dap" },
      ["<leader>t"] = { name = "+test" },
      ["<leader>sn"] = { name = "+noice" },

      -- NOTE: my own defaults
      ["<leader>?"] = { name = printf("notes") },
      ["<leader>o"] = { name = printf("obsidian") },
      ["<leader>h"] = { name = printf("harpoon") },
      ["<leader>m"] = { name = printf("mark") },
    },
    window = {
      border = "rounded",       -- none, single, double, shadow, rounded
      position = "bottom",      -- bottom, top
      margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
      padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
      winblend = 0,
    },
  },

  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
