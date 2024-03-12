local icons = {
  File = "󰈙 ",
  Module = " ",
  Namespace = "󰌗 ",
  Package = " ",
  Class = "󰌗 ",
  Method = "󰆧 ",
  Property = " ",
  Field = " ",
  Constructor = " ",
  Enum = "󰕘",
  Interface = "󰕘",
  Function = "󰊕 ",
  Variable = "󰆧 ",
  Constant = "󰏿 ",
  String = "󰀬 ",
  Number = "󰎠 ",
  Boolean = "◩ ",
  Array = "󰅪 ",
  Object = "󰅩 ",
  Key = "󰌋 ",
  Null = "󰟢 ",
  EnumMember = " ",
  Struct = "󰌗 ",
  Event = " ",
  Operator = "󰆕 ",
  TypeParameter = "󰊄 ",
}

local nvim_navic = {
  "SmiteshP/nvim-navic",
  event = "VeryLazy",
  dependencies = { "neovim/nvim-lspconfig" },
  config = function()
    require("nvim-navic").setup({
      icons = icons,
      lsp = {
        auto_attach = true,
        preference = nil,
      },
      highlight = false,
      separator = " > ",
      depth_limit = 5,
      depth_limit_indicator = "..",
      safe_output = true,
      lazy_update_context = false,
      click = true,
    })
  end,
}

return {
  nvim_navic,
  -- {
  --   "utilyre/barbecue.nvim",
  --   name = "barbecue",
  --   event = "VeryLazy",
  --   version = "*",
  --   dependencies = {
  --     -- "SmiteshP/nvim-navic",
  --     nvim_navic,
  --     "nvim-tree/nvim-web-devicons", -- optional dependency
  --   },
  --   opts = {
  --     -- configurations go here
  --   },
  -- },

  -- navbuddy
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
          "numToStr/Comment.nvim",
          "nvim-telescope/telescope.nvim",
        },
        opts = {
          lsp = { auto_attach = true },
          icons = icons,
          window = { border = "rounded" },
        },
      },
    },
    keys = {
      { "<leader>cb", "<cmd>Navbuddy<cr>", desc = "Navbuddy (LSP Nav)" },
    },
  },
}
