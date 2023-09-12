return {
  "catppuccin/nvim",
  name = "catppuccin",
  event = "VeryLazy",
  -- enabled = false,
  -- lazy = false, -- make sure we load this during startup if it is your main colorscheme
  -- priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    -- to disable notification when using transparent_background
    require("notify").setup({
      background_colour = "#000000",
    })

    -- vim.cmd("hi TreesitterContextBottom gui=underline guisp=Grey")
    -- vim.cmd("hi Visual cterm=none gui=none guibg=#ffffff")

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
      highlight_overrides = {
        all = function(_) -- colors
          return {
            Comment = { fg = "#4d4b49" }, -- comments
            FlashBackdrop = { fg = "#4d4b49" },
            Operator = { fg = "#d1d1d1" }, -- operator := etc
            Boolean = { fg = "#7833f5" },
            Number = { fg = "#d11d9b" },
            Type = { fg = "#438c5e" },
            TreesitterContextLineNumber = { fg = "#d1d1d1" },
            -- TreesitterContextBottom = { sp = "#d1d1d1" },
            FlashLabel = { fg = "#ffffff" },
            Visual = { bg = "#292930" }, -- Visual cterm=bold gui=bold guibg=#292930
            -- Visual = { bg = "#292930", cterm = "", gui = "" }, -- Visual cterm=bold gui=bold guibg=#292930
            -- FIX:
            Identifier = { fg = "#added6" }, -- const, field, golang var / field in struct etc.
            -- Identifier = { fg = "#a2ded4" }, -- const, field, golang var / field in struct etc.
            -- Identifier = { fg = "#94e2d5" }, -- const, field, golang var / field in struct etc.
            -- Identifier = { fg = "#b2dbb7" }, -- const, field, golang var / field in struct etc.

            ["@variable.builtin"] = { fg = "#3463fa" }, -- golang nil, if ST (semanteic token) is enabled, it will overwrite goNil
            -- ["@variable.builtin"] = { fg = "#4044ff" }, -- golang nil, if ST (semanteic token) is enabled, it will overwrite goNil
            ["@type.builtin"] = { fg = "#F79327" }, -- primitive type: string, int, float etc in golang
            -- ["@type.builtin"] = { fg = "#bf9d54" }, -- primitive type: string, int, float etc in golang
            -- Float = { fg = "#d1d1d1" },
            ["@parameter"] = { fg = "#bf5836" }, -- from vim.cmd("highlight @parameter guifg=#5c26bf")

            -- go highlighter
            ["goStructTypeField"] = { fg = "#79a3d9" }, -- go struct field
            -- ["goStructTypeField"] = { fg = "#7497c4" }, -- go struct field
            ["PreProc"] = { fg = "#b0abab" }, -- go tag string. other?
            -- ["goStructTypeField"] = { fg = "#53c2a9" }, -- go struct field
            -- ["goStructTypeField"] = { fg = "#3bd9b6" }, -- go struct field
            -- ["goStructTypeField"] = { fg = "#21b897" }, -- go type?
            -- ["goStringFormat"] = { fg = "#10b7c7" }, -- will overwrite "Special" but only for golang

            -- rust highlighter
            -- ["@function.builtin"] = { fg = "#21b897" }, -- go type?

            -- TODO: lsp.typemod below need to change to blue like fn highlighter
            ["Special"] = { fg = "#10b7c7" }, -- special char in string. go: "%v" / rust: "{:}"
            ["@lsp.typemod.function.defaultLibrary"] = { fg = "#0286c7" }, -- rust. package function. ex. env::var(). var will be highlighted
            -- ["@lsp.typemod.method.defaultLibrary"] = { fg = "#438c5e" }, -- rust. -- change the color?
            ["@lsp.typemod.macro.defaultLibrary"] = { fg = "#94e2d5" }, -- rust. macro liek println!
            ["@constant.builtin"] = { fg = "#438c5e" }, -- rust. return type? in match?
            -- #94e2d5
          }
        end,
      },
      color_overrides = {
        all = {

          -- {
          --   -- springGreen = "#ba866c", -- string
          --   fujiGray = "#4d4b49", -- comments
          --   oniViolet = "#ad2650", -- func, defer etc. also affects var, let, local, anonym func in lua and js
          --   peachRed = "#ad2650", -- return and exception handling in other language. return in go will will be the same as function / "oniViolet" color
          --   sakuraPink = "#BC1B8C", -- number
          --   -- sakuraPink = "#9e3380", -- number
          --   springBlue = "#7f51e0", -- nil, require, builtin func, and indent line / Specials and builtin functions
          --   waveRed = "#ab9e9a", -- golang tag string in struct / Standout specials 1 (builtin variables). rust macro
          --   crystalBlue = "#0286c7", -- Functions and Titles
          --   carpYellow = "#10b7c7", -- Identifiers. will be a go package name when enabled with semantic highlight
          --   waveAqua2 = "#438c5e", -- types
          --   surimiOrange = "#84c496", -- Constants, imports, booleans. also nil in golang / when semantic hi is enabled golang's nil is changed to "springBlue"
          --   boatYellow2 = "#d1d1d1", -- Operators => . != ==
          --   springViolet1 = "#d1d1d1", -- Light foreground / special color for treesitter-context. it is the same color as the params but it is not changed at all except when the params is in at treesitter-context sticky header. it will change color to this
          --   sumiInk0 = "none", -- Dark background (statuslines and floating windows)
          --   sumiInk4 = "none", -- treesitter context highlight / Darker foreground (line numbers, fold column, non-text characters), float borders
          --   -- #1c495f
          --   -- TODO: find out how to change params color when semantic highlight is enabled
          -- }

          peach = "#BC1B8C", -- number
          text = "#ccc6ab", -- var
          red = "#a10524", -- NOTE:  disable for now. as it will overwrite the following: rainbow bracket, nil / overwrite goNil highlighter when using semantic token, param var
          -- red = "#d42f62", -- NOTE:  disable for now. as it will overwrite the following: rainbow bracket, nil / overwrite goNil highlighter when using semantic token, param var

          -- maroon = "#ffffff", -- has connection with red?

          green = "#C58674", -- string
          -- yellow = "#438c5e", -- types, warning string and symbol
          blue = "#0286c7", -- funct and titles
          pink = "#8d5afa", -- #nil, require, builtin func, and indent line / Specials and builtin functions
          -- teal = "#ffffff", -- color of NOTE: and rainbow bracket
          -- subtext0 = "",
          -- rosewater = "",

          -- crust = "#ffffff",
          -- lavender = "#209FB5", -- Identifiers. will be a go package name when enabled with semantic highlight
          lavender = "#10b7c7", -- Identifiers. will be a go package name when enabled with semantic highlight
          mauve = "#d42f62", -- return and exception handling in other language. return in go will will be the same as function / "oniViolet" color
          -- sapphire = "#0286c7", -- Functions and Titles",
        },
        -- TODO: do not change comment with 'valid'
        mocha = {

          -- Green = "#C58674",
          color2 = "#C58674",
          -- lavender = "#9cdcfe",
          -- flamingo = "#c6cccf",
          -- text = "#93d1f1", -- valid
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
        alpha = true,
        nvimtree = false,
        ts_rainbow = true,
        cmp = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        noice = true,
        notify = true,
        neotree = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
        harpoon = true,
        dap = true,
      },
    })
  end,
}
