local hl_colors = {
  dark_blue = "#0286c7",
  types = "#15a191",
  todo_NOTE = "#15a191",
  todo_TODO = "#18a4db",
  todo_WARN = "#b0ab8b",
  todo_HACK = "#7833f5",
  todo_FIX = "#a10524",
}

return {
  "catppuccin/nvim",
  name = "catppuccin",
  event = "VeryLazy",
  -- enabled = false,
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    -- to disable notification when using transparent_background
    -- require("notify").setup({
    --   background_colour = "#000000",
    -- })

    vim.api.nvim_set_hl(0, "@lsp.type.string.go", {}) -- disable nvim 0.10 lsp string highlight that causes conflict with goStringFormat.

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
            Operator = { fg = "#d1d1d1" }, -- operator := , * & etc.
            Boolean = { fg = "#7833f5" },
            Number = { fg = "#87b7c7" },
            Type = { fg = hl_colors.types },
            TreesitterContextLineNumber = { fg = "#d1d1d1" },
            -- TreesitterContextBottom = { sp = "#d1d1d1" },

            -- change the treesitter todo highlighter such as 'NOTE' and 'TODO'. the default is too bright.
            -- NOTE.
            TodoBgNOTE = { bold = true, bg = hl_colors.todo_NOTE, fg = "#000000" }, -- example to use bold and others. ex. TodoBgNOTE    xxx gui=bold guifg=#000000 guibg=#94e2d5
            TodoSignNOTE = { fg = hl_colors.todo_NOTE },
            TodoFgNOTE = { fg = hl_colors.todo_NOTE },
            -- TODO.
            TodoBgTODO = { bold = true, bg = hl_colors.todo_TODO, fg = "#000000" },
            TodoSignTODO = { fg = hl_colors.todo_TODO },
            TodoFgTODO = { fg = hl_colors.todo_TODO },
            -- WARN.
            TodoBgWARN = { bold = true, bg = hl_colors.todo_WARN, fg = "#000000" },
            TodoSignWARN = { fg = hl_colors.todo_WARN },
            TodoFgWARN = { fg = hl_colors.todo_WARN },
            -- HACK.
            TodoBgHACK = { bold = true, bg = hl_colors.todo_HACK, fg = "#000000" },
            TodoSignHACK = { fg = hl_colors.todo_HACK },
            TodoFgHACK = { fg = hl_colors.todo_HACK },
            -- FIX.
            TodoBgFIX = { bold = true, bg = hl_colors.todo_FIX, fg = "#000000" },
            TodoSignFIX = { fg = hl_colors.todo_FIX },
            TodoFgFIX = { fg = hl_colors.todo_FIX },

            LspInlayHint = { fg = "#3e4d4c" },
            FlashLabel = { fg = "#ffffff" },
            Visual = { bg = "#292930" }, -- Visual cterm=bold gui=bold guibg=#292930
            Identifier = { fg = "#5885b0" }, -- const, field, golang var / field in struct etc.
            -- Float = { fg = "#d1d1d1" },
            ["@parameter"] = { fg = "#9c4528" }, -- parameter var in a func

            ["@string.special.url"] = { fg = "#a89996" }, -- string url
            -- ["Special"] = { fg = "#10b7c7" }, -- special char in string. go: "%v" / rust: "{:}" / overwrite var in go. dont use it. it is too general

            MiniIndentscopeSymbol = { fg = "#74c7ec" }, -- indent animation color

            -- fix the rainbow color that linked to string hl color
            RainbowDelimiterGreen = { fg = "#0d8c4f" },
            rainbow4 = { link = "RainbowDelimiterGreen" },
            rainbowcol7 = { link = "RainbowDelimiterGreen" },
            RainbowDelimiterViolet = { link = "rainbowcol5" },
            rainbow6 = { link = "rainbowcol5" },

            -- go highlighter
            ["@variable.builtin"] = { fg = "#d61c9f" }, -- golang nil, if ST (semanteic token) is enabled, it will overwrite goNil
            ["@type.builtin"] = { fg = "#ab9d3c" }, -- primitive type: string, int, float etc in golang
            -- ["goVarIdentifier"] = { fg = "#55B4BE" }, -- go const. but not imported const (will follow Identifier). is commented as the default is linked to Identifier
            ["goStructTypeField"] = { fg = "#10b7c7" }, -- go struct field
            goVarAssign = { fg = "#D7658B" }, -- go overwrite var
            -- ["goConstDecl"] = { fg = "#79a3d9" },
            -- ["goIota"] = { fg = "#79a3d9" },
            ["PreProc"] = { fg = "#9c9797" }, -- go tag string.
            ["goStringFormat"] = { fg = "#10b7c7" }, -- will overwrite "Special" but only for golang.

            -- rust highlighter
            ["@punctuation.special"] = { fg = "#10b7c7" }, -- rust "{}"
            ["@string.special"] = { fg = "#10b7c7" }, -- special char in string. go: "%v"
            ["@lsp.typemod.function.defaultLibrary"] = { fg = "#0286c7" }, -- rust. package function. ex. env::var(). var will be highlighted
            ["@lsp.typemod.macro.defaultLibrary"] = { fg = "#94e2d5" }, -- rust. macro liek println!
            ["@constant.builtin"] = { link = "Type" }, -- rust. return type? in match?. should be indental with Type
            -- available color #da8ede /
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

          -- peach = "#BC1B8C", -- number
          peach = "#da8ede", -- number
          text = "#b0ab8b", -- var
          -- text = "#bab49b", -- var
          red = "#a10524",
          -- red = "#d42f62", -- NOTE:  disable for now. as it will overwrite the following: rainbow bracket, nil / overwrite goNil highlighter when using semantic token, param var

          -- maroon = "#ffffff", -- has connection with red?

          green = "#ad7666", -- string
          -- yellow = "#438c5e", -- types, warning string and symbol
          blue = hl_colors.dark_blue, -- funct and titles
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
        nvimtree = true,
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
