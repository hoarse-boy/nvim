-- return {}

local Util = require("lazyvim.util")

local M = {}

--- Get highlight properties for a given highlight name
---@param name string The highlight group name
---@param fallback? table The fallback highlight properties
---@return table properties # the highlight group properties
function M.get_hlgroup(name, fallback)
  if vim.fn.hlexists(name) == 1 then
    local hl
    hl = vim.api.nvim_get_hl(0, { name = name, link = false })
    if not hl.fg then
      hl.fg = "NONE"
    end
    if not hl.bg then
      hl.bg = "NONE"
    end
    return hl
  end
  return fallback or {}
end

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      -- PERF: we don't need this lualine require madness 🤷
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = require("lazyvim.config").icons

      vim.o.laststatus = vim.g.lualine_laststatus

      local get_hlgroup = M.get_hlgroup
      -- local get_hlgroup = require("core.utils").get_hlgroup
      local colours = {
        bg = get_hlgroup("Normal").bg,
        fg = "#d6d6d0",
        grey = "#d1d1d1",
        -- grey = "#565f89",
        green = "#15a191",
        -- green = "#9ece6a",
        yellow = "#e0af68",
        blue = "#0286c7",
        -- blue = "#7aa2f7",
        magenta = "#7833f5",
        -- magenta = "#bb9af7",
        red = "#a10524",
        -- red = "#f7768e",
        gitOrange = "#F24D29",
        cyan = "#7dcfff",
        orange = "#ff9e64",
      }
      local copilot_colours = {
        [""] = { fg = colours.grey, bg = colours.bg },
        ["Normal"] = { fg = colours.grey, bg = colours.bg },
        ["Warning"] = { fg = colours.red, bg = colours.bg },
        ["InProgress"] = { fg = colours.yellow, bg = colours.bg },
      }

      return {
        options = {
          component_separators = { left = " ", right = " " },
          theme = {
            normal = {
              a = { fg = colours.blue, bg = colours.bg },
              b = { fg = colours.cyan, bg = colours.bg },
              c = { fg = colours.fg, bg = colours.bg },
              x = { fg = colours.fg, bg = colours.bg },
              y = { fg = colours.magenta, bg = colours.bg },
              -- z = { fg = colours.grey, bg = colours.bg }, -- NOTE: comment to make the z section to match each mode color
            },
            insert = {
              a = { fg = colours.green, bg = colours.bg },
              -- z = { fg = colours.grey, bg = colours.bg }, -- NOTE: comment to make the z section to match each mode color
            },
            visual = {
              a = { fg = colours.magenta, bg = colours.bg },
              -- z = { fg = colours.grey, bg = colours.bg }, -- NOTE: comment to make the z section to match each mode color
            },
            command = {
              a = { fg = colours.grey, bg = colours.bg },
            },
            replace = {
              a = { fg = colours.red, bg = colours.bg },
            },
            terminal = {
              a = { fg = colours.orange, bg = colours.bg },
              -- z = { fg = colours.grey, bg = colours.bg }, -- NOTE: comment to make the z section to match each mode color
            },
          },

          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
        },

        sections = {
          lualine_a = { { "mode", icon = "" } },
          lualine_b = {
            { "branch", icon = { "", color = { fg = colours.gitOrange } } },
          },
          -- lualine_b = { { "branch", icon = "" } },
          -- lualine_b = { { "branch", icon = "" } },

          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },

            { Util.lualine.pretty_path() },
            --  {
            --   "filename",
            --   symbols = { modified = "  ", readonly = "", unnamed = "" },
            -- },

            -- nvim navic
            {
              function()
                return require("nvim-navic").get_location()
              end,
              cond = function()
                return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
              end,
              color = { fg = colours.grey, bg = colours.bg },
            },
          },

          lualine_x = {
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = { fg = colours.green },
            },
            {
              function()
                local icon = " "
                local status = require("copilot.api").status.data
                return icon .. (status.message or "")
              end,
              cond = function()
                local ok, clients = pcall(vim.lsp.get_active_clients, { name = "copilot", bufnr = 0 })
                return ok and #clients > 0
              end,
              color = function()
                if not package.loaded["copilot"] then
                  return
                end
                local status = require("copilot.api").status.data
                return copilot_colours[status.status] or copilot_colours[""]
              end,
            },

            {
              function()
                return "  " .. require("dap").status()
              end,
              cond = function()
                return package.loaded["dap"] and require("dap").status() ~= ""
              end,
              color = Util.ui.fg("Debug"),
            },
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = Util.ui.fg("Special"),
            },

            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },

          lualine_y = {
            {
              "progress",
            },
            {
              "location",
              color = { fg = colours.cyan, bg = colours.bg },
            },
          },

          lualine_z = {
            {
              function()
                return "  " .. os.date("%X")
                -- return "  " .. os.date("%X") .. " 📎"
              end,
              color = { fg = colours.grey, bg = colours.bg },
            },
            {
              function()
                return "󰐝"
              end,
            },
          },
        },
        extensions = { "neo-tree", "lazy" },
      }
    end,
  },

  -- NOTE: move modicator here to avoid error in notify.
  -- will always use lualine so this is fine
  {
    "mawkler/modicator.nvim",
    event = "VeryLazy",
    init = function()
      -- These are required for Modicator to work
      vim.o.cursorline = true
      vim.o.number = true
      vim.o.termguicolors = true
    end,
    config = function()
      require("modicator").setup({
        -- Show warning if any required option is missing
        show_warnings = false,
        highlights = {
          -- Default options for bold/italic
          defaults = {
            bold = true,
            italic = true,
          },
        },
        integration = {
          lualine = {
            enabled = false,
          },
        },
      })

      vim.api.nvim_set_hl(0, "NormalMode", { link = "lualine_a_normal" })
      vim.api.nvim_set_hl(0, "InsertMode", { link = "lualine_a_insert" })
      vim.api.nvim_set_hl(0, "VisualMode", { link = "lualine_a_visual" })
      vim.api.nvim_set_hl(0, "SelectMode", { link = "lualine_a_visual" })
      vim.api.nvim_set_hl(0, "CommandMode", { link = "lualine_a_command" })
      vim.api.nvim_set_hl(0, "ReplaceMode", { link = "lualine_a_replace" })
      vim.api.nvim_set_hl(0, "TerminalMode", { link = "lualine_a_terminal" })
      vim.api.nvim_set_hl(0, "TerminalNormalMode", { link = "lualine_a_terminal" })
    end,
  },
}
