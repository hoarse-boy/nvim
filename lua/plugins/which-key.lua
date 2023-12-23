-- return {
--   "folke/which-key.nvim",
--   -- NOTE: use opts to not overwrite default lazyvim
--   opts = function(_, opts)
--     -- FIX: not working now?
--     opts.window = {
--       border = "single", -- none, single, double, shadow
--       position = "top", -- bottom, top
--       margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
--       padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
--       winblend = 0,
--     }

--     -- NOTE: use below to create custom keymaps
--     local wk = require("which-key")
--     wk.setup(opts)
--     local keymaps = {
--       mode = { "n", "v" },
--       -- examples
--       -- ["g"] = { name = "+goto" },
--       -- ["gs"] = { name = "+surround" },
--       -- ["]"] = { name = "+next" },
--       -- ["["] = { name = "+prev" },
--       ["<leader>?"] = { name = "+notes" },
--       ["<leader>o"] = { name = "+others" },
--       ["<leader>gh"] = { name = "+hunks" }, -- TODO: not working?
--       -- ["<leader>w"] = { name = "+windows" },
--       -- ["<leader>x"] = { name = "kabom" }, -- disabled trouble.nvim  keymaps
--     }
--     wk.register(keymaps, opts)

--     -- NOTE: make whichkey transparent
--     -- TODO: find a way to trigger this cmd if a transparent theme
--     -- vim.cmd("hi WhichKeyFloat ctermbg=BLACK ctermfg=BLACK")
--   end,
-- }

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
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
      ["<leader>gh"] = { name = "+hunks" }, -- FIX: not working?
      ["<leader>q"] = { name = "+quit/session" },
      ["<leader>s"] = { name = "+search" },
      ["<leader>u"] = { name = "+ui" },
      ["<leader>w"] = { name = "+windows" },
      ["<leader>x"] = { name = "+diagnostics/quickfix" },

      -- NOTE: my own defaults
      ["<leader>?"] = { name = "+notes" },
      ["<leader>o"] = { name = "+others" },
    },
    window = {
      border = "single", -- none, single, double, shadow
      position = "top", -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
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
