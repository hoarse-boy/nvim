return {
  "folke/which-key.nvim",
  event = "VeryLazy",

  -- NOTE: use opts to not overwrite default lazyvim
  opts = function(_, opts)
    opts.plugins = { spelling = true }
    opts.window = {
      border = "single", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
      winblend = 0,
    }

    local wk = require("which-key")
    wk.setup(opts)
    local keymaps = {
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
      ["<leader>gh"] = { name = "+hunks" },
      ["<leader>q"] = { name = "+quit/session" },
      ["<leader>s"] = { name = "+search" },
      ["<leader>u"] = { name = "+ui" },
      ["<leader>w"] = { name = "+windows" },
      ["<leader>x"] = nil, -- disabled trouble.nvim  keymaps

      -- add own keymaps. the rest should be in respective
      ["<leader>d"] = { name = "+debug" },
      ["<leader>h"] = { name = "+harpoon" },
    }

    local Util = require("lazyvim.util")
    if Util.has("noice.nvim") then
      keymaps["<leader>sn"] = { name = "+noice" }
    end

    wk.register(keymaps)

    -- NOTE: make whichkey transparent
    -- TODO: find a way to trigger this cmd if a transparent theme
    vim.cmd("hi WhichKeyFloat ctermbg=BLACK ctermfg=BLACK")
  end,
}
