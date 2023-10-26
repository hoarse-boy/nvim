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

return {
  {
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
        click = false,
      })
    end,
  },

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
