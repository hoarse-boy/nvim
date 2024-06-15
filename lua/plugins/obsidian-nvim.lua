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

return {
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
    -- Required.
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/google-drive/obsidian-vault/",
      },
      -- {
      --   name = "work",
      --   path = "~/Google Drive/My Drive/My Vault",
      -- },
    },

    notes_subdir = "inbox",
    new_notes_location = "notes_subdir",

    disable_frontmatter = true,
    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M:%S",
    },

    mappings = {}, -- disable default keybindings.
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    -- Specify how to handle attachments.
    attachments = {
      -- The default folder to place images in via `:ObsidianPasteImg`.
      -- If this is a relative path it will be interpreted as relative to the vault root.
      -- You can always override this per image by passing a full path to the command instead of just a filename.
      img_folder = "_resources/", -- This is the default
      -- A function that determines the text to insert in the note when pasting an image.
      -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
      -- This is the default implementation.
      -- ---@param client obsidian.Client
      -- ---@param path obsidian.Path the absolute path to the image file
      -- ---@return string
      -- img_text_func = function(client, path)
      --   path = client:vault_relative_path(path) or path
      --   return string.format("![%s](%s)", path.name, path)
      -- end,
    },
  },
  keys = {
    -- stylua: ignore
    { "<leader>of", "<cmd>ObsidianFollowLink<cr>", desc = "Obsidian Go to File", mode = "n" },
    -- stylua: ignore
    { "<leader>oo", "<cmd>ObsidianOpen<cr>", desc = "Obsidian Open", mode = "n" },
    -- stylua: ignore
    { "<leader>oc", function() return toggle_checkbox_and_date()  end, desc = "Obsidian Toggle Checkbox", mode = "n" },
    { "gt", function() return toggle_checkbox_and_date()  end, desc = "Obsidian Toggle Checkbox", mode = "n" },
    -- { "<leader>oc", function() return require("obsidian").util.toggle_checkbox()  end, desc = "Obsidian Toggle Checkbox", mode = "n" }, -- NOTE: made my custom func to make better checkbox.
    -- { "<leader>os", function() return require("obsidian").util.smart_action()  end, desc = "Obsidian Smart Action", mode = "n" }, -- Smart action depending on context, either follow link or toggle checkbox.
  },
}
