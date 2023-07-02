return {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function(_, opts)
    require("nvim-surround").setup({
      keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "ys",
        normal_cur = "yss",
        normal_line = "yS",
        normal_cur_line = "ySS",
        visual = "gsa",
        visual_line = "gS",
        delete = "gsd",
        change = "gsc",
        change_line = "gcS",
      },
    })

    local wk = require("which-key")
    wk.setup(opts)
    local keymaps = {
      mode = { "n", "v" },
      ["gs"] = { name = "+surround" },
    }
    wk.register(keymaps, opts)
  end,
}
