local printf = require("plugins.util.printf").printf

local logo = [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣶⣶⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠸⠿⠿⠿⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⡀⠀⠀⠀⠀⠀⣠⣾⣿⠀⠀⣠⣿⣿⣷⣄⡀⠀⠀⠀⠀⣠⣾⣷⡀⠀⠀⠀⢀⣾⣿⠀⠀⠀⠀⣠⣾⡇⠀⠀⣰⣿⣿⣷⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣷⠀⠀⠀⠀⢾⣿⣿⣿⡄⠀⠻⢿⣿⣿⣿⣿⣦⡀⠀⠐⣿⣿⣿⣇⠀⠀⠀⣿⣿⣿⡇⠀⠀⢴⣿⣿⣿⠀⠘⠻⢿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣧⠀⠀⠀⠘⣿⣿⣿⡇⠀⠀⠀⠉⠻⣿⣿⣿⡇⠀⠀⠸⣿⣿⣿⡄⠀⠀⢸⣿⣿⡇⠀⠀⠘⣿⣿⣿⠀⠀⠀⠀⠈⠻⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⡆⠀⠀⠀⣿⣿⣿⡇⠀⣀⣀⣀⠀⢹⣿⣿⡇⠀⠀⠀⢻⣿⣿⣧⠀⠀⣼⣿⡿⠀⠀⠀⠀⣿⣿⣿⠀⠀⠀⠀⠀⠀⢸⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⡀⠀⠀⣸⣿⣿⠇⠀⣿⣿⣿⠀⢸⣿⣿⡇⠀⠀⠀⠘⣿⣿⣿⣶⣾⣿⠟⠀⠀⠀⠀⠀⣿⣿⡏⠀⠀⠀⠀⠀⢀⣿⣿⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣧⠀⢀⣿⣿⡟⠀⠀⠈⠉⠉⠀⢸⣿⣿⡇⠀⠀⠀⠀⢻⣿⣿⣿⠟⠁⠀⠀⠀⠀⢀⣼⣿⡿⠀⠀⠀⠀⠀⢠⣾⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⣾⣿⣿⠟⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⡇⠀⠀⠀⠀⠈⣿⣿⣿⡆⠀⠀⣀⣤⣶⣿⣿⠟⠀⠀⠀⠀⠀⠀⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣶⣾⣿⣿⣿⣿⡿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⡇⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⡿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⣿⡿⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⠏⠀⠀⠀⠀⠀⠀⠀⠙⠿⠿⠿⠿⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⠛⠉⠁⣶⣶⣶⣶⣶⣶⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣶⣶⡆⢰⣶⣶⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⠛⠛⠛⠛⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠿⠿⠃⠸⠿⠿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
]]

-- modify existing dashboard shortcut in config.center. the one showing when launching nvim.
local function update_dashboard_shortcut(opts, current_keymap, new_action, new_desc)
  for _, item in ipairs(opts.config.center) do
    if item.key == current_keymap then
      item.action = new_action
      item.desc = new_desc
    end
  end
end

local function remove_dashboard_item(opts, key_to_remove)
  for index, item in ipairs(opts.config.center) do
    if item.key == key_to_remove then
      table.remove(opts.config.center, index)
      break
    end
  end
end

-- NOTE: dashboard can alter buffer no. line and signcolumn when openingg buffer from trouble-nvim.
-- this is the message when running "verbose :set nu? rnu? signcolumn?" in vim command. need to run nvim -V1 in terminal to see the full message.
-- nonumber
-- 	Last set from ~/.local/share/nvim/lazy/dashboard-nvim/lua/dashboard/init.lua line 82
-- norelativenumber
-- 	Last set from ~/.local/share/nvim/lazy/dashboard-nvim/lua/dashboard/init.lua line 82
--   signcolumn=no
-- 	Last set from ~/.local/share/nvim/lazy/dashboard-nvim/lua/dashboard/init.lua line 82
return {
  {
    "nvimdev/dashboard-nvim",
    -- enabled = false,
    opts = function(_, opts)
      -- NOTE: create the braille at https://asciiart.club/
      -- https://superemotes.com/img2ascii#google_vignette -- just copy the text.

      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")

      -- TODO: update obsidian_todos and obsidian_inbox to have dynamic dir using util function. for macos and arch linux.

      -- add new dashboard item obsidian_todos.
      local obsidian_todos = {
        action = [[lua require("plugins.util.teles-find").ChangeDirAndFindFiles("~/google-drive/obsidian-vault/todos/")]],
        desc = printf("Obsidian Todos"),
        icon = "  ",
        key = "t",
      }

      obsidian_todos.desc = obsidian_todos.desc .. string.rep(" ", 43 - #obsidian_todos.desc)
      obsidian_todos.key_format = "  %s"

      table.insert(opts.config.center, 2, obsidian_todos)

      -- add new dashboard item obsidian_inbox.
      local obsidian_inbox = {
        action = [[lua require("plugins.util.teles-find").ChangeDirAndFindFiles("~/google-drive/obsidian-vault/inbox/")]],
        desc = printf("Obsidian Inbox"),
        icon = "󱉳  ",
        key = "i",
      }

      obsidian_inbox.desc = obsidian_inbox.desc .. string.rep(" ", 43 - #obsidian_inbox.desc)
      obsidian_inbox.key_format = "  %s"

      table.insert(opts.config.center, 3, obsidian_inbox)

      local lazyvim_config = {
        action = [[lua require("plugins.util.teles-find").ChangeDirAndFindFiles("~/.local/share/nvim/lazy/LazyVim/")]],
        desc = printf("Lazyvim Config"),
        icon = "  ",
        key = "L",
      }

      lazyvim_config.desc = lazyvim_config.desc .. string.rep(" ", 43 - #lazyvim_config.desc)
      lazyvim_config.key_format = "  %s"

      table.insert(opts.config.center, 11, lazyvim_config)

      update_dashboard_shortcut(opts, "c", [[lua require("plugins.util.teles-find").ChangeDirAndFindFiles("~/.config/nvim/")]], " Config")

      -- remove some defaults dashboard items.
      remove_dashboard_item(opts, "n")
      remove_dashboard_item(opts, "x")
    end,
  },
  {
    "folke/which-key.nvim",
    opts = function(_, _)
      local wk = require("which-key")
      local mapping = {
        { "<leader>D", "<cmd>Dashboard<cr>", icon = "󰨇 ", group = printf("Dashboard"), mode = "n" },
      }
      wk.add(mapping)
    end,
  },
}

-- list of all other logos

-- local logo = [[
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⢀⣶⠁⢠⣶⠞⠀⣠⣴⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣮⢀⣠⣷⣿⣶⣿⣿⣶⣾⣿⣿⣷⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣦⣿⣿⣯⣿⢿⣿⣯⣿⣏⣏⣯⣯⣯⣯⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⣶⣾⣿⣫⣯⣟⢯⣫⣮⣿⣷⣾⣯⣯⣿⣯⣯⣿⣯⣯⣿⣷⠒⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⢈⣤⣯⣻⣮⠿⠛⠋⠛⠛⣿⣿⣿⣏⣯⣯⣿⣯⣯⣯⣿⣷⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠁⡀⠀⠀⠀⠀⠀⠀⠉⣿⣿⣯⣿⣿⣿⣿⣯⣯⣿⠓⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣨⣿⣫⢏⢟⣻⣯⣏⣇⣿⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣇⣫⣪⣮⣮⣯⣏⣯⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣫⣎⣇⣧⣮⣮⣯⣯⣿⡟⠓⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣴⣶⣶⣶⣤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣟⣮⣯⣧⣯⣯⣿⣯⣿⣿⠁⠀⣴⣧⠀⠀⠀⣠⠀⠀⣠⣔⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣯⣿⣯⣯⣿⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣯⣯⣯⣯⣯⣯⣯⡿⠁⣿⣶⠀⣿⣿⡄⢀⣯⡏⢀⣶⣿⠋⠀⠀⠀⠀⠀⠀⠀⣿⣯⣿⣿⣿⣿⣿⣯⣿⣯⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣯⣯⣯⣿⣯⣯⣿⣿⡄⠀⣸⣿⣴⣿⣿⣿⣯⣿⣷⣿⣿⣿⣤⣶⠏⠀⠀⠀⠀⠀⠀⢻⣿⣯⣿⣿⣿⣿⣿⣿⣯⣯⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣯⣯⣯⣯⣏⣿⣿⣿⣾⣿⣿⣯⣿⣿⣯⣟⣿⣿⣿⣿⣿⣿⣥⡤⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣯⠙⣿⣿⣯⣿⣿⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣯⣿⣿⣯⣯⣯⣯⣿⣯⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣤⡀⢀⢀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣟⠀⢻⣿⣿⣿⣿⣿⣦⣀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⡄
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⢿⣿⣯⣯⣿⣿⣿⣿⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⡏⠀⠀⠙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣮⣤⣴⣤⣤⣶⣷⣶⣶⣶⣿⣿⣿⠁
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣯⣯⣿⣿⣿⣿⣿⣯⣿⣿⣿⣯⣧⣿⣿⣯⣯⣿⣯⣿⣿⣯⣯⣿⡟⠀⠀⠀⠀⠉⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠛⠁⠀
-- ⠀⠀⠀⠀⢀⣄⣀⣤⣶⣾⣶⣿⣿⣯⣿⣿⣿⣿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣯⣯⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠉⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠏⠀⠀⠀⠀⠀
-- ⠈⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠀⠀⠀⠀⠉⠉⠉⠉⠉⠉⠉⠉⠉⠋⠋⠉⠉⠉⠉⠉⠻⢿⠻⢿⣯⠯⢯⠿⢿⢿⠶⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠛⣯⠉⠉⠛⠿⠉⠉⠙⠀⠀⠀⠀⠀⠀⠀⠀⠀
--     ]]

--     local logo = [[
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢴⡷⠀⠀⠀⠀⠀⡠⢾⠀⠀⠀⢰⣶⣆⣀⠀⠀⠀⠀⡀⡆⠀⠀⠀⠀⣠⢆⠀⠀⠀⢀⣴⡄⠀⠀⣴⣾⣦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠫⣿⢡⠀⠀⠀⠀⢺⣿⡆⠀⠀⠈⠋⠾⣿⣶⠀⠀⠀⠩⣫⡄⠀⠀⠀⡿⣿⠀⠀⠀⢸⣾⡇⠀⠀⠈⠙⠹⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⡆⠀⠀⠀⠘⣿⡇⠀⠀⠀⠀⠀⢹⣿⠀⠀⠀⠀⠼⣟⠀⠀⠀⣸⡊⠀⠀⠀⠘⣿⡇⠀⠀⠀⠀⠀⠈⣳⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣭⠀⠀⠀⠀⣿⠇⠀⠀⣶⡆⠀⢸⣿⠀⠀⠀⠀⠘⣿⣆⢀⣤⠏⠀⠀⠀⠀⠀⣿⠃⠀⠀⠀⠀⠀⢰⡞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣥⠀⠀⣠⡕⠀⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⠛⣟⠛⠀⠀⠀⠀⠀⠀⢼⠃⠀⠀⠀⠀⠀⠰⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⢫⡤⡮⠚⠀⠀⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⠈⣗⣇⠀⠀⢀⡠⡰⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣲⣲⠿⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠟⠀⠀⠀⠀⠀⠀⠹⣿⣿⡻⠻⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠛⠁⣀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⠀⢀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠛⠛⠛⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠛⠀⠘⠛⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
--     ]]
