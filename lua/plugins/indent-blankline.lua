-- FIX: experimental

-- return {
--   {
--     "lukas-reineke/indent-blankline.nvim",
--     branch = "v3",
--     event = "BufReadPre",
--     config = function()
--       local hl_name_list = {
--         "RainbowDelimiterRed",
--         "RainbowDelimiterYellow",
--         "RainbowDelimiterOrange",
--         "RainbowDelimiterGreen",
--         "RainbowDelimiterBlue",
--         "RainbowDelimiterCyan",
--         "RainbowDelimiterViolet",
--       }
--       require("ibl").setup({
--         scope = {
--           enabled = true,
--           show_start = false,
--           highlight = hl_name_list,
--         },
--       })
--       local hooks = require("ibl.hooks")
--       hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
--     end,
--   },
--   -- {
--   --   "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
--   --   config = function()
--   --     local colors = {
--   --       Red = "#EF6D6D",
--   --       Orange = "#FFA645",
--   --       Yellow = "#EDEF56",
--   --       Green = "#6AEF6F",
--   --       Cyan = "#78E6EF",
--   --       Blue = "#70A4FF",
--   --       Violet = "#BDB2EF",
--   --     }
--   --     require("pynappo.theme").set_rainbow_colors("RainbowDelimiter", colors) -- just a helper function that sets the highlights with the given prefix
--   --     local rainbow_delimiters = require("rainbow-delimiters")

--   --     vim.g.rainbow_delimiters = {
--   --       strategy = {
--   --         [""] = rainbow_delimiters.strategy["global"],
--   --         vim = rainbow_delimiters.strategy["local"],
--   --       },
--   --       query = {
--   --         [""] = "rainbow-delimiters",
--   --       },
--   --       highlight = {
--   --         "RainbowDelimiterRed",
--   --         "RainbowDelimiterYellow",
--   --         "RainbowDelimiterOrange",
--   --         "RainbowDelimiterGreen",
--   --         "RainbowDelimiterBlue",
--   --         "RainbowDelimiterCyan",
--   --         "RainbowDelimiterViolet",
--   --       },
--   --     }
--   --   end,
--   -- },
-- }

-- return {
--   "lukas-reineke/indent-blankline.nvim",
--   event = { "BufReadPost", "BufNewFile" },
--   branch = "v3",
--   -- opts = {
--   --   -- char = "▏",
--   --   char = "│",
--   --   show_trailing_blankline_indent = false,
--   --   -- show_current_context = false,
--   --   show_current_context = true,
--   --   show_current_context_start = true,
--   --   -- show_current_context_start = false,
--   --   space_char_blankline = " ", -- NOTE: i think this make the strange '>' when the window is out of focus from the indent
--   -- },
--   config = function()
--     -- require("ibl").setup() -- FIX:
--     require("ibl").setup({
--       exclude = {
--         "help",
--         "alpha",
--         "dashboard",
--         "neo-tree",
--         "Trouble",
--         "lazy",
--         "mason",
--         "notify",
--         "toggleterm",
--         "lazyterm",
--       },
--       -- scope = {
--       -- },
--       -- char = "|",
--       char = "▏",
--       -- tab_char = { "a", "b", "c" },
--       -- highlight = { "Function", "Label" },
--       smart_indent_cap = true,
--       priority = 2,
--     })

-- vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
-- vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
-- require("ibl").setup({ scope = { highlight = { "RainbowRed", "RainbowBlue" } } })
-- local hooks = require("ibl.hooks")
-- hooks.register(hooks.type.SCOPE_HIGHLIGHT, function(_, _, scope, _)
--   if scope:type() == "if_statement" then
--     return 2
--   end
--   return 1
-- end)
--   end,
-- }

-- { -- FIX:
--     "lukas-reineke/indent-blankline.nvim",
--     event = { "BufReadPost", "BufNewFile" },
--     opts = {
--       -- char = "▏",
--       char = "│",
--       filetype_exclude = {
--         "help",
--         "alpha",
--         "dashboard",
--         "neo-tree",
--         "Trouble",
--         "lazy",
--         "mason",
--         "notify",
--         "toggleterm",
--         "lazyterm",
--       },
--       show_trailing_blankline_indent = false,
--       show_current_context = false,
--     },
--   }

-- FIX: v2
-- return {
--   "lukas-reineke/indent-blankline.nvim",
--   event = { "BufReadPost", "BufNewFile" },
--   opts = {
--     char = "▏",
--     -- char = "│",
--     filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
--     show_trailing_blankline_indent = false,
--     -- show_current_context = false,
--     show_current_context = true,
--     -- show_current_context_start = true,
--     -- show_current_context_start = false,
--     space_char_blankline = " ", -- NOTE: i think this make the strange '>' when the window is out of focus from the indent

--     -- show_current_context = true, -- FIX:
--     show_current_context_start = true, -- FIX:
--   },
-- }

local char_symbol = "▏"

-- NOTE: best v2 with wezterm enable undercurl => https://wezfurlong.org/wezterm/faq.html#how-do-i-enable-undercurl-curly-underlines
-- make this for v3 for the rainbow hooks
return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    -- enabled = false, -- FIX: try other indent plugin
    config = function()
      require("indent_blankline").setup({
        show_current_context = true,
        show_current_context_start = true,
        space_char_blankline = " ",
        char = char_symbol,
        show_trailing_blankline_indent = false,
        indentLine_char = char_symbol,
        blankline_char = char_symbol, -- FIX: check this
        -- context_char_blankline = "", -- NOTE: this will make the highlight gone for empty lines
        -- indent_blankline_char = " ",
        -- indent_blankline_context_char = char_symbol, -- FIX:
      })

      vim.g.indent_blankline_context_char = char_symbol -- NOTE:
    end,
  },

  {
    -- NOTE: overwrite lazyvim's as this plugin helps overwrite the strange char in terminal (wezTerm and kitty)
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    enabled = false, -- FIX:
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mini.indentscope").setup({
        draw = {
          delay = 0,
          priority = 2,
          -- priority = 9,
        },
        symbol = char_symbol,
        options = { try_as_border = true },
      })
    end,
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  -- {
  --   "shellRaining/hlchunk.nvim",
  --   event = { "UIEnter" },
  --   config = function()
  --     require("hlchunk").setup({
  --       chunk = {
  --         enable = true,
  --         notify = true,
  --         use_treesitter = true,
  --         -- details about support_filetypes and exclude_filetypes in https://github.com/shellRaining/hlchunk.nvim/blob/main/lua/hlchunk/utils/filetype.lua
  --         -- support_filetypes = ft.support_filetypes,
  --         -- exclude_filetypes = ft.exclude_filetypes,
  --         chars = {
  --           horizontal_line = "─",
  --           vertical_line = char_symbol,
  --           left_top = "╭",
  --           left_bottom = "╰",
  --           right_arrow = ">",
  --         },
  --         style = {
  --           { fg = "#806d9c" },
  --           { fg = "#c21f30" }, -- this fg is used to highlight wrong chunk
  --         },
  --         textobject = "",
  --         max_file_size = 1024 * 1024,
  --         error_sign = true,
  --       },
  --       line_num = {
  --         enable = false,
  --         -- enable = true,
  --         use_treesitter = true,
  --         style = "#806d9c",
  --       },
  --       indent = {
  --         enable = true,
  --         -- enable = false,
  --         use_treesitter = false,
  --         chars = {
  --           char_symbol,
  --         },
  --         style = {
  --           { fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui") },
  --         },
  --       },
  --       blank = {
  --         enable = false,
  --         chars = {
  --           "․",
  --         },
  --         style = {
  --           vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
  --         },
  --       },
  --     })
  --   end,
  -- },
}
