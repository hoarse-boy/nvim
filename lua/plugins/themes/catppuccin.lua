return {
  "catppuccin/nvim",
  name = "catppuccin",
  event = "VeryLazy",
  -- enabled = false,
  -- lazy = false, -- make sure we load this during startup if it is your main colorscheme
  -- priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      transparent_background = true,
      show_end_of_buffer = false, -- show the '~' characters after the end of buffers
      term_colors = true,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.05,
      },
      no_italic = false, -- Force no italic
      no_bold = false, -- Force no bold
      styles = {
        comments = { "italic" },
        conditionals = {},
        loops = {},
        functions = { "italic" },
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = { "italic" },
        properties = {},
        types = { "italic" },
        operators = {},
      },
      color_overrides = {

        -- TODO: do not change comment with 'valid'
        mocha = {
          -- lavender = "#9cdcfe",
          -- flamingo = "#c6cccf",
          text = "#93d1f1", -- valid
          -- red = "#F38BA8",
          -- maroon = "#F38BA8",
          -- subtext1 = "#DEBAD4",
          -- subtext0 = "#C8A6BE",
          -- overlay2 = "#B293A8",
          -- overlay1 = "#9C7F92",
          -- overlay0 = "#866C7D",
          -- surface2 = "#705867",
          -- surface1 = "#5A4551",
          -- surface0 = "#44313B",

          -- base = "#352939",
          -- mantle = "#211924",
          -- crust = "#1a1016",

          -- surface2 = "#b9826c", -- for comment
        }, -- Override to make it look like vscode?
      },

      -- custom_highlights = function(colors)
      --   return {
      -- Comment = { fg = colors.flamingo },
      -- ["@constant.builtin"] = { fg = colors.peach, style = {} },
      -- ["@comment"] = { fg = colors.surface2, style = { "italic" } },
      --   }
      -- end,

      integrations = {
        telescope = true,
        notify = true,
        harpoon = true,
        neotree = true,
        treesitter = true,
        treesitter_context = true,
        leap = true,
        which_key = true,
        lsp_trouble = true, -- trouble.nvim
        dap = true,
        noice = true,
        mini = true,
        -- special = true,

        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
    })
  end,
}
