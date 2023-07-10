local brighterColor = {
  fujiWhite = "#ccc6ab", -- variable
  springGreen = "#C58674", -- string
  -- springGreen = "#ba866c", -- string
  fujiGray = "#4d4b49", -- comments
  oniViolet = "#ad2650", -- func, defer etc. also affects var, let, local, anonym func in lua and js
  peachRed = "#ad2650", -- return and exception handling in other language. return in go will will be the same as function / "oniViolet" color
  sakuraPink = "#BC1B8C", -- number
  -- sakuraPink = "#9e3380", -- number
  springBlue = "#7f51e0", -- nil, require, builtin func, and indent line / Specials and builtin functions
  waveRed = "#ab9e9a", -- golang tag string in struct / Standout specials 1 (builtin variables). rust macro
  crystalBlue = "#0286c7", -- Functions and Titles
  carpYellow = "#10b7c7", -- Identifiers. will be a go package name when enabled with semantic highlight
  waveAqua2 = "#438c5e", -- types
  surimiOrange = "#84c496", -- Constants, imports, booleans. also nil in golang / when semantic hi is enabled golang's nil is changed to "springBlue"
  boatYellow2 = "#d1d1d1", -- Operators => . != ==
  springViolet1 = "#d1d1d1", -- Light foreground / special color for treesitter-context. it is the same color as the params but it is not changed at all except when the params is in at treesitter-context sticky header. it will change color to this
  sumiInk0 = "none", -- Dark background (statuslines and floating windows)
  sumiInk4 = "none", -- treesitter context highlight / Darker foreground (line numbers, fold column, non-text characters), float borders
  -- #1c495f
  -- TODO: find out how to change params color when semantic highlight is enabled
}

local myColor = {
  fujiWhite = "#a19c87", -- variable
  -- fujiWhite = "#b8b39a", -- variable
  -- fujiWhite = "#DCD7BA", -- variable
  springGreen = "#916854", -- string
  -- springGreen = "#AC7B63", -- string
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
  oniViolet = "#851e3e", -- func, defer etc. also affects var, let, local, anonym func in lua and js
  -- oniViolet = "#983B6E", -- func, defer etc. also affects var, let, local, anonym func in lua and js
  peachRed = "#851e3e", -- return and exception handling in other language. return in go will will be the same as function / "oniViolet" color
  -- sakuraPink = "#b0457f", -- number
  sakuraPink = "#983B6E", -- number
  -- sakuraPink = "#c76320", -- number
  -- sakuraPink = "#A69B97", -- number
  springBlue = "#6A44BB", -- nil, require, builtin func, and indent line / Specials and builtin functions
  lightBlue = "#ffffff", -- not used?
  -- springBlue = "#aa58ed", -- nil, require, builtin func, and indent line / Specials and builtin functions
  waveRed = "#7a716e", -- golang tag string in struct / Standout specials 1 (builtin variables)
  -- waveRed = "#918884", -- golang tag string in struct / Standout specials 1 (builtin variables)
  crystalBlue = "#0B6DA2", -- Functions and Titles
  waveAqua2 = "#2f6141", -- types
  -- waveAqua2 = "#113e21", -- types
  -- waveAqua2 = "#6a995e", -- types
  surimiOrange = "#679975", -- Constants, imports, booleans. also nil in golang / when semantic hi is enabled golang's nil is changed to "springBlue"
  -- surimiOrange = "#7dba8e", -- Constants, imports, booleans. also nil in golang / when semantic hi is enabled golang's nil is changed to "springBlue"
  carpYellow = "#0c8a96", -- Identifiers. will be a go package name when enabled with semantic highlight
  -- carpYellow = "#0fa3b1", -- Identifiers. will be a go package name when enabled with semantic highlight
  boatYellow2 = "#aaaaaa", -- Operators => . != ==
  -- boatYellow2 = "#bbbbbb",
  -- katanaGray = "#ffffff", -- deprecated
  -- springViolet1 = "#000000", -- Light foreground
  -- springViolet2 = "#BF026D", -- comma, indent line, ;
  -- sumiInk4 = "#000000", -- comma / Darker foreground (line numbers, fold column, non-text characters), float borders
}

return {
  "rebelot/kanagawa.nvim",
  -- lazy = false, -- make sure we load this during startup if it is your main colorscheme
  lazy = true,
  -- priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require("kanagawa").setup({
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true, italic = true },
      typeStyle = { italic = true },
      variablebuiltinStyle = {},
      -- specialReturn = false, -- special highlight for the return keyword
      specialReturn = true, -- special highlight for the return keyword
      -- specialException = false, -- special highlight for exception handling keywords
      specialException = true, -- special highlight for exception handling keywords
      transparent = true, -- do not set background color
      -- transparent = false, -- do not set background color
      dimInactive = false, -- dim inactive window `:h hl-NormalNC`
      globalStatus = false, -- adjust window separators highlight for laststatus=3
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      colors = {
        theme = { all = { ui = { bg_gutter = "none" } } },
        palette = brighterColor,
        -- palette = myColor,
      },

      overrides = function(colors)
        local theme = colors.theme
        return {
          -- Pmenu = { blend = vim.o.pumblend }, -- TODO: what does it do?

          -- NOTE: the same as vim.cmd("highlight TelescopeBorder guibg=none") in lazy.lua
          -- make the ugly border highlight diseapper
          -- TODO: add an if, kanagawa transparent is true add above
          TelescopeBorder = { bg = "none" },
          FloatBorder = { bg = "none" },
          NormalFloat = { bg = "none" },
          TelescopeTitle = { bg = "none" },
          TelescopeNormal = { bg = "none" },
          CursorLine = { bg = "#2e2e33" }, -- NOTE: make the cursorline transparent or just disable it in option.lua opt.cursorline = false
          -- CursorLine = { bg = "none" },
          -- should not be colored the same as function / return / (currently red) and go func name which (currently blue)
          ["@parameter"] = { fg = "#A48111" }, -- from vim.cmd("highlight @parameter guifg=#5c26bf")
        }
      end,

      -- colors = myColor,
      -- overrides = {},
      -- theme = "default", -- Load "default" theme or the experimental "light" theme
    })
  end,
}
