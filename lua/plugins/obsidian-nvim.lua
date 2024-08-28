-- Define the custom function to toggle checkbox and manage date and symbol
local function toggle_checkbox_and_date()
  -- Get the current date in the desired format
  local date = os.date("%Y-%m-%d")

  -- Define the symbol and date string
  local symbol_and_date = "✅ " .. date

  -- Get the current line content
  local line = vim.api.nvim_get_current_line()

  -- Check if the line has a checkbox
  local checkbox_pattern = "^(%s*)%- %[ %]"
  local checked_pattern = "^(%s*)%- %[x%]"

  if string.match(line, checkbox_pattern) then
    -- Replace '- [ ]' with '- [x]' and append the symbol and date
    local new_line = line:gsub(checkbox_pattern, "%1- [x]") .. " " .. symbol_and_date
    vim.api.nvim_set_current_line(new_line)
  elseif string.match(line, checked_pattern) then
    -- Replace '- [x]' with '- [ ]' and remove the symbol and date
    local new_line = line:gsub(checked_pattern, "%1- [ ]"):gsub(" ✅ %d%d%d%d%-%d%d%-%d%d$", "")
    vim.api.nvim_set_current_line(new_line)
  elseif line:match("^%s*$") then
    -- If the line is empty or only contains whitespace, add '- [ ] ' and place the cursor at the correct position
    local indent = line:match("^(%s*)")
    local new_line = indent .. "- [ ] "
    vim.api.nvim_set_current_line(new_line)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>A", true, false, true), "n", true)
  else
    -- Prepend '- [ ]' to the line if it doesn't have a checkbox
    local indent = line:match("^(%s*)")
    local new_line = indent .. "- [ ] " .. line:sub(#indent + 1)
    vim.api.nvim_set_current_line(new_line)
  end
end

local obsidian_path = "~/google-drive/obsidian-vault"

local os_util = require("plugins.util.check-os")
local os_name =  os_util.get_os_name()
-- my current macos has different directory.
if os_name == os_util.OSX then
  obsidian_path = "~/My Drive/obsidian-vault"
end

local printf = require("plugins.util.printf").printf

local my_img_folder = "_resources/"
local notes_subdir = "inbox"
local obsidian_extract_note_desc = printf("Extract Note in ") .. notes_subdir

return {
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    event = "VeryLazy",
    -- ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("obsidian").setup({
        workspaces = {
          {
            name = "work",
            path = obsidian_path,
          },
        },
        notes_subdir = notes_subdir,
        new_notes_location = "notes_subdir",
        disable_frontmatter = true,
        templates = {
          subdir = "templates",
          date_format = "%Y-%m-%d",
          time_format = "%H:%M:%S",
        },

        -- TODO: update this to create work's todo.
        -- create its template using the daily todo in GUI (see Daily notes core plugin's option).
        -- create shell command that when creating new todo works alongside GUI core plugin.
        -- need to refactor the directory structure. currently it is inside nested folder of Office.
        -- change it "work/daily-todo" to host all daily todos. create a shell to mv done todo to "work/done".
        -- create new dir "work/todo" to host all of the todos that will be linked to "work/daily-todo".
        -- create new dir "work/done" to host all of the todos that has been done.
        -- use the current date like "Thu 20 Jun 2024", or change it?
        -- the template is "Office/Stand up/Daily Todo/Daily Todo template". it will use the same template but the file will be moved.
        -- update keybindings for daily notes.
        daily_notes = {
          folder = "work/daily-todo",
          -- Optional, if you want to change the date format for the ID of daily notes.
          date_format = "%Y-%m-%d",
          -- Optional, if you want to change the date format of the default alias of daily notes.
          alias_format = "%B %-d, %Y",
          -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
          template = nil,
        },

        mappings = {}, -- disable default keybindings.
        completion = {
          nvim_cmp = true,
          min_chars = 2,
        },
      })
    end,
    keys = {
      { "<leader>og", "<cmd>ObsidianFollowLink<cr>", desc = printf("Go to Linked File"), mode = "n" },
      { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = printf("Open List of Backlinks"), mode = "n" },
      { "<leader>oe", "<cmd>ObsidianExtractNote<cr>", desc = obsidian_extract_note_desc, mode = "v" },
      { "<leader>ol", "<cmd>ObsidianLink<cr>", desc = printf("Find Matching Note and Create Link"), mode = "v" },
      { "<leader>ol", "<cmd>ObsidianLinks<cr>", desc = printf("List Links in Current Note"), mode = "n" },
      { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = printf("Search or Create New Note"), mode = "n" },
      { "<leader>oo", "<cmd>ObsidianOpen<cr>", desc = printf("Open File in GUI"), mode = "n" },
      -- stylua: ignore
      { "<leader>oc", function() return toggle_checkbox_and_date() end, desc = printf "Toggle Checkbox",                     mode = "n" },
      -- stylua: ignore
      { "gt",         function() return toggle_checkbox_and_date() end, desc = printf "Toggle Checkbox",                     mode = "n" },
      -- { "<leader>op", "<cmd>ObsidianPasteImg<cr>", desc = printf"Obsidian Paste Image", mode = "n" }, -- NOTE: this suck. use the plugin below instead.
    },
  },

  {
    "folke/which-key.nvim",
    opts = function(_, _)
      local wk = require("which-key")
      local mapping = {
        { "<leader>o", icon = "󱞁", group = printf("obsidian"), mode = "n" },
      }
      wk.add(mapping)
    end,
  },

  -- this plugin can imitate the obsidian paste image function.
  {
    "dfendr/clipboard-image.nvim",
    event = "VeryLazy",
    -- enabled = false, -- disabled plugin
    keys = {
      { "<leader>op", "<cmd>PasteImg<cr>", mode = "n", desc = printf("Paste Image"), noremap = true, silent = true },
    },
    config = function()
      require("clipboard-image").setup({
        -- Default configuration for all filetype
        default = {
          img_name = function()
            return os.date("%Y-%m-%d-%H-%M-%S")
          end, -- Example result: "2021-04-13-10-04-18"
          affix = "<\n  %s\n>", -- Multi lines affix
        },
        -- You can create configuration for ceartain filetype by creating another field (markdown, in this case)
        -- If you're uncertain what to name your field to, you can run `lua print(vim.bo.filetype)`
        -- Missing options from `markdown` field will be replaced by options from `default` field
        markdown = {
          img_dir = { "~", "google-drive", "obsidian-vault", "_resources" }, -- Use table for nested dir (New feature form PR #20)
          img_dir_txt = "", -- no directory name as it uses obsidian wiki format.
          -- NOTE: this one if failed. create strange text in nvim.
          -- img_handler = function(img) -- New feature from PR #22
          -- local script = string.format('./image_compressor.sh "%s"', img.path)
          -- os.execute(script)
          -- end,

          img_name = function()
            local random_number = math.random(1000000, 9999999)
            return string.format("%s%s", os.date("%Y-%m-%d-%H-%M-%S"), random_number)
          end, -- Example result: "2021-04-13-10-04-18-1234567"
          affix = "![[%s]]", -- NOTE: for obsidian wiki format.
        },
      })
    end,
  },
}
