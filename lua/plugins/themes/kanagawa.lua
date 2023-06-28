local myColor = {
  fujiWhite = "#b8b39a", -- variable
  -- fujiWhite = "#DCD7BA", -- variable
  springGreen = "#AC7B63", -- string
  -- springGreen = "#01AE78", -- string
  -- oldWhite = "#000000",
  sumiInk0 = "none", -- Dark background (statuslines and floating windows)
  -- sumiInk1 = "#ffffff", -- Default background
  -- sumiInk2 = "#ffffff", -- Lighter background (colorcolumn, folds)
  -- sumiInk3 = "#ffffff", -- Lighter background (cursorline)
  sumiInk4 = "#181824", -- treesitter context highlight / Darker foreground (line numbers, fold column, non-text characters), float borders
  -- waveBlue1 = "#ffffff", -- Popup background, visual selection background
  -- waveBlue2 = "#ffffff", -- Popup background, visual selection background
  -- winterGreen = "#ffffff", -- Diff Add (background)
  -- winterYellow = "#ffffff", -- Diff Change (background)
  -- winterRed = "#ffffff", -- Diff Deleted (background)
  -- winterBlue = "#ffffff", -- Diff Line (background)
  -- autumnGreen = "#ffffff", -- Git Add
  -- autumnRed = "#ffffff", -- Git Delete
  -- autumnYellow = "#ffffff", -- Git Change
  -- samuraiRed = "#ffffff", -- Diagnostic Error
  -- roninYellow = "#ffffff", -- Diagnostic Warning
  -- waveAqua1 = "#ffffff", -- Diagnostic Info
  -- dragonBlue = "#ffffff", -- Diagnostic Hint
  -- dragonBlue = "#ffffff", -- Diagnostic Hint

  fujiGray = "#4d4b49", -- comments
  -- oniViolet = "#ff483f", -- func, defer etc. also affects var, let, local, anonym func in lua and js
  -- oniViolet = "#ff6961", -- func, defer etc. also affects var, let, local, anonym func in lua and js
  oniViolet = "#983B6E", -- func, defer etc. also affects var, let, local, anonym func in lua and js
  -- oniViolet = "#B14564", -- func, defer etc. also affects var, let, local, anonym func in lua and js
  sakuraPink = "#c76320", -- number
  -- sakuraPink = "#fa7d28", -- number
  -- sakuraPink = "#f58231", -- number
  -- sakuraPink = "#A69B97", -- number
  springBlue = "#6A44BB", -- nil, require, builtin func, and indent line / Specials and builtin functions
  lightBlue = "#ffffff", -- not used?
  -- springBlue = "#aa58ed", -- nil, require, builtin func, and indent line / Specials and builtin functions
  waveRed = "#AE7C12", -- golang tag string in struct / Standout specials 1 (builtin variables)
  -- peachRed = "#ffffff", -- return and exception handling
  crystalBlue = "#0B6DA2", -- Functions and Titles
  waveAqua2 = "#6a995e", -- types
  -- waveAqua2 = "#58804f", -- types
  -- waveAqua2 = "#01AE78", -- types
  -- waveAqua2 = "#A19591", -- types
  surimiOrange = "#7dba8e", -- Constants, imports, booleans. also nil in golang
  -- surimiOrange = "#90d6a4", -- Constants, imports, booleans. also nil in golang
  -- surimiOrange = "#aaffc3", -- Constants, imports, booleans. also nil in golang
  -- surimiOrange = "#808000", -- Constants, imports, booleans. also nil in golang
  -- surimiOrange = "#ffd8b1", -- Constants, imports, booleans. also nil in golang
  -- surimiOrange = "#9A6D38", -- Constants, imports, booleans. also nil in golang
  carpYellow = "#0fa3b1", -- Identifiers. will be a go package name when enabled with semantic highlight
  -- carpYellow = "#65ACE4", -- Identifiers. will be a go package name when enabled with semantic highlight
  -- TODO: change to smokoed white
  -- boatYellow2 = "#DCD7BA", -- Operators => , . != ==
  -- boatYellow2 = "#B14564", -- Operators => , . != == and / Operators, RegEx
  -- boatYellow1 = "#ffffff", -- not used?
  -- katanaGray = "#ffffff", -- deprecated
  -- springViolet1 = "#000000",
  -- springViolet2 = "#BF026D", -- comma, indent line, ;
  -- sumiInk4 = "#000000", -- comma / Darker foreground (line numbers, fold column, non-text characters), float borders
}

return {
  "rebelot/kanagawa.nvim",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    -- Default options:
    require("kanagawa").setup({
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = { italic = true },
      variablebuiltinStyle = {},
      specialReturn = true, -- special highlight for the return keyword
      specialException = true, -- special highlight for exception handling keywords
      transparent = true, -- do not set background color
      -- transparent = false, -- do not set background color
      dimInactive = false, -- dim inactive window `:h hl-NormalNC`
      -- dimInactive = true, -- dim inactive window `:h hl-NormalNC`
      globalStatus = false, -- adjust window separators highlight for laststatus=3
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      colors = {
        theme = { all = { ui = { bg_gutter = "none" } } },
        palette = myColor,
      },

      -- NOTE: make the telescope not transparent
      -- overrides = function(colors)
      --   local theme = colors.theme
      --   return {
      --     TelescopeTitle = { fg = theme.ui.special, bold = true },
      --     TelescopePromptNormal = { bg = theme.ui.bg_p1 },
      --     TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
      --     TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
      --     TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
      --     TelescopePreviewNormal = { bg = theme.ui.bg_dim },
      --     TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
      --   }
      -- end,

      overrides = function(colors)
        local theme = colors.theme
        return {
          Pmenu = { blend = vim.o.pumblend }, -- TODO: what does it do?
          -- Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
          -- PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          -- PmenuSbar = { bg = theme.ui.bg_m1 },
          -- PmenuThumb = { bg = theme.ui.bg_p2 },
          -- TelescopePromptNormal = { bg = theme.ui.bg_p1, blend = vim.o.pumblend },
          -- TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.pmenu.bg, blend = vim.o.pumblend },
          -- TelescopePreviewNormal = { bg = theme.ui.bg_dim, blend = vim.o.pumblend },
          -- TelescopeTitle = { fg = theme.ui.special, bold = true },
          -- TelescopePromptNormal = { bg = "none" },
          -- TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = "none" }, -- NOTE: fg changes the border line. in this case bg_p1 will make it less prominent
          -- TelescopeResultsNormal = { fg = theme.ui.bg_p1, bg = "none" },
          -- TelescopeResultsBorder = { fg = theme.ui.bg_p1, bg = "none" },
          -- TelescopePreviewNormal = { bg = "none" },
          -- TelescopePreviewBorder = { bg = "none", fg = theme.ui.bg_p1 },

          -- NOTE: the same as vim.cmd("highlight TelescopeBorder guibg=none") in layz.lua
          -- make the ugly border highlight diseapper
          -- TODO: add an if, if kanagawa transparent is true add above
          TelescopeBorder = { bg = "none" },
          FloatBorder = { bg = "none" },
          NormalFloat = { bg = "none" },
          TelescopeTitle = { bg = "none" },
          TelescopeNormal = { bg = "none" },
        }
      end,

      -- colors = myColor,
      -- overrides = {},
      -- theme = "default", -- Load "default" theme or the experimental "light" theme
    })
  end,
}
