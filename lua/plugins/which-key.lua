return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    -- opts = {
    -- TODO: 
    -- add icon for 'command history' in which-key with symbol ':'
    -- disable notify.

    ---@type false | "classic" | "modern" | "helix"
    opts.preset = "modern"

    opts.win = {
      -- don't allow the popup to overlap with the cursor
      no_overlap = true,
      -- width = 1,
      -- height = { min = 4, max = 25 },
      -- col = 0,
      -- row = math.huge,
      -- border = "none",
      padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
      title = true,
      title_pos = "center",
      zindex = 1000,
      -- Additional vim.wo and vim.bo options
      bo = {},
      wo = {
        -- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
      },
    }

    -- update which-key mapping
    local wk = require("which-key")
    local mapping = {
      { "<leader>:", icon = "󰋚", group = "Command History", mode = "n" }, -- NOTE: just add a symbol, not a new custom keymap.
      { "<leader>K", icon = "", group = "Keywordprg", mode = "n", hidden = true },
    }

    wk.add(mapping)
  end,
}
