local colors = {
  blue = "#80a0ff",
  cyan = "#79dac8",
  black = "#080808",
  white = "#c6c6c6",
  red = "#ff5189",
  violet = "#d183e8",
  grey = "#303030",
}

local modicator_nvim = {
  "mawkler/modicator.nvim",
  init = function()
    -- These are required for Modicator to work
    vim.o.cursorline = true
    vim.o.number = true
    vim.o.termguicolors = true
  end,
  config = function()
    require("modicator").setup({
      show_warnings = false,
      highlights = {
        defaults = {
          bold = true,
          italic = true,
        },
      },
      integration = {
        lualine = {
          enabled = false, -- it will have background color. so we need to disable it.
        },
      },
    })

    vim.api.nvim_set_hl(0, "NormalMode", { fg = colors.cyan })
    vim.api.nvim_set_hl(0, "InsertMode", { fg = colors.blue })
    vim.api.nvim_set_hl(0, "VisualMode", { fg = colors.violet })
    vim.api.nvim_set_hl(0, "SelectMode", { fg = colors.violet })
    vim.api.nvim_set_hl(0, "CommandMode", { fg = colors.white })
    vim.api.nvim_set_hl(0, "ReplaceMode", { fg = colors.red })
    vim.api.nvim_set_hl(0, "TerminalMode", { fg = colors.white })
    vim.api.nvim_set_hl(0, "TerminalNormalMode", { fg = colors.white })
  end,
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.cyan },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.violet } },
  replace = { a = { fg = colors.black, bg = colors.red } },
  command = { a = { fg = colors.black, bg = colors.white } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white },
  },
}

local word_count = {
  function()
    local words = vim.fn.wordcount()["words"]
    return "Words: " .. words
  end,
  cond = function()
    local ft = vim.opt_local.filetype:get()
    local count = {
      latex = true,
      tex = true,
      text = true,
      markdown = true,
      vimwiki = true,
    }
    return count[ft] ~= nil
  end,
  color = { fg = colors.cyan },
}

-- TODO: make it look good with more symbol. and only shows one lsp client.
local lsp = {
  function()
    local all_clients = vim.lsp.get_clients()
    if #all_clients == 0 then
      return "LSP Inactive"
    end

    local client_names = {}

    -- add client
    for _, client in pairs(all_clients) do
      if client.name ~= "null-ls" and client.name ~= "copilot" then
        table.insert(client_names, client.name)
      end
    end

    local unique_client_names = table.concat(client_names, ", ")
    local language_servers = string.format(" [%s]", unique_client_names)

    return language_servers
  end,
  color = { fg = "#62a0c4", gui = "bold" },
}

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      modicator_nvim,
    },
    opts = function(_, opts)
      -- Set theme and separators
      opts.options = {
        theme = bubbles_theme,
        component_separators = "",
        section_separators = { left = "", right = "" },
        disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
        globalstatus = true,
      }

      opts.sections.lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } } -- init value from lazyvim is just { "mode" }. so we need to overwrite it.
      opts.sections.lualine_y = { { "location", padding = { left = 1, right = 1 } } }

      -- table.insert(opts.sections.lualine_x, 1, lsp) -- takes too much space. need to be refined to return only one client.
      table.insert(opts.sections.lualine_x, 1, word_count)

      opts.sections.lualine_z = {
        {
          function()
            return "  " .. os.date("%X")
          end,
          separator = { right = "" },
        },
      }

      vim.o.laststatus = vim.g.lualine_laststatus
    end,
  },
}

-- TODO: find a way to append into existing lua list to not clutter this plugin. example is like copilot above.
-- also to make a seperate code for each code. to easily enable or disable whithout changing this code.
-- check this link https://github.com/LazyVim/LazyVim/discussions/925
-- the only way is to not use any of lazyvim plugin at all. or find a way to make an order. in this case this nvim-lualine.lua should run first.
-- TODO: i have found the way, next update small plugins to table.insert

-- NOTE: these are the old code. I will keep them here for reference.

-- Ensure opts.sections.lualine_a is defined and structured correctly
-- if opts.sections and opts.sections.lualine_a then
--   -- Check if lualine_a is a table with the correct structure
--   if type(opts.sections.lualine_a[1]) == "string" then
--     -- Convert to the correct structure
--     opts.sections.lualine_a = {
--       { "mode", separator = { left = "" }, right_padding = 1 },
--     }
--   end

--   -- Log before modification
--   -- log_table(opts.sections.lualine_a, "Before modification")

--   -- Modify the separator for "mode"
--   for _, section in ipairs(opts.sections.lualine_a) do
--     if section[1] == "mode" then
--       section.separator = { left = "" }
--       section.right_padding = 2
--     end
--   end

--   --   -- Log after modification
--   --   log_table(opts.sections.lualine_a, "After modification")
--   -- else
--   --   vim.notify("opts.sections.lualine_a is not defined or empty", vim.log.levels.ERROR)
-- end

-- -- modify existing dashboard shortcut in config.center. the one showing when launching nvim.
-- local function update_dashboard_shortcut(opts, current_keymap, new_action, new_desc)
--   for _, item in ipairs(opts.config.center) do
--     if item.key == current_keymap then
--       item.action = new_action
--       item.desc = new_desc
--     end
--   end
-- end

-- local function deep_copy(orig)
--   local orig_type = type(orig)
--   local copy
--   if orig_type == "table" then
--     copy = {}
--     for orig_key, orig_value in next, orig, nil do
--       copy[deep_copy(orig_key)] = deep_copy(orig_value)
--     end
--     setmetatable(copy, deep_copy(getmetatable(orig)))
--   else
--     copy = orig
--   end
--   return copy
-- end
