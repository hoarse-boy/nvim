local char_symbol = "▏"

-- NOTE: best v2 with wezterm enable undercurl => https://wezfurlong.org/wezterm/faq.html#how-do-i-enable-undercurl-curly-underlines
-- disable these plugins to use one plugin that can do both without mini.indentscope performance hit.
return {
  -- indent guides for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "LazyFile",
    -- enabled = false, -- disabled plugin
    opts = {
      indent = {
        -- char = "│",
        -- tab_char = "│",
        char = char_symbol,
        tab_char = char_symbol,
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
          "nvimtree",
        },
      },
    },
    main = "ibl",
  },

  -- Active indent guide and indent text objects. When you're browsing
  -- code, this highlights the current level of indentation, and animates
  -- the highlighting.
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    -- enabled = false, -- disabled plugin
    event = "LazyFile",
    opts = {
      -- symbol = "▏",
      -- symbol = "│",
      symbol = char_symbol,
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
          "nvimtree",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}
