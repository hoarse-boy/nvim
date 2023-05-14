-- return {
--   {
--     -- default which-key has no border and that's ugly when using transaparant background
--     "folke/which-key.nvim",
--     -- NOTE: use opts if in lazy.nvim if dont want to remove default settings from lazyvim
--     -- else use config = func to overwrite everything.
--     opts = {
--       window = {
--         border = "single", -- none, single, double, shadow
--         position = "bottom", -- bottom, top
--         margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
--         padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
--         winblend = 0,
--       },
--     },
--   },
-- }

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = { spelling = true },
    window = {
      border = "single", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
      winblend = 0,
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    local keymaps = {
      mode = { "n", "v" },
      ["g"] = { name = "+goto" },
      ["gz"] = { name = "+surround" },
      ["]"] = { name = "+next" },
      ["["] = { name = "+prev" },
      ["<leader><tab>"] = { name = "+tabs" },
      ["<leader>b"] = { name = "+buffer" },
      -- ["<leader>c"] = { name = "+code" },
      ["<leader>f"] = { name = "+file/find" },
      ["<leader>g"] = { name = "+git" },
      ["<leader>gh"] = { name = "+hunks" },
      ["<leader>q"] = { name = "+quit/session" },
      ["<leader>s"] = { name = "+search" },
      ["<leader>u"] = { name = "+ui" },
      ["<leader>w"] = { name = "+windows" },
      -- ["<leader>x"] = { name = "+diagnostics/quickfix" },
    }
    local Util = require("lazyvim.util")
    if Util.has("noice.nvim") then
      keymaps["<leader>sn"] = { name = "+noice" }
    end
    wk.register(keymaps)
  end,
}
