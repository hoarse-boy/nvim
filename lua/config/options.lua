-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt
local api = vim.api

vim.opt.fillchars = { eob = " " } -- NOTE: removes trailing '~' in nvim

if vim.g.neovide then
  opt.guifont = "JetBrainsMono Nerd Font:h17.5" -- the font used in graphical neovim applications

  -- Helper function for transparency formatting
  local alpha = function()
    return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
  end
  -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
  vim.g.neovide_transparency = 0.0
  vim.g.transparency = 0.89
  vim.g.neovide_background_color = "#000000" .. alpha()

  vim.g.neovide_input_macos_alt_is_meta = false
  vim.g.neovide_cursor_vfx_mode = "railgun"

  vim.g.neovide_input_use_logo = 1 -- enable use of the logo (cmd) key
  vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
  vim.keymap.set("v", "<D-c>", '"+y') -- Copy
  vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
  vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
  vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
  vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
end

-- opt.winbar = "%=%m %f"
opt.cursorline = true
-- opt.cursorcolumn = true
opt.scrolloff = 10 -- minimal number of screen lines to keep above and below the cursor.
opt.sidescrolloff = 10 -- minimal number of screen lines to keep left and right of the cursor.
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
opt.swapfile = false -- creates a swapfile (i hate this thing, MUST BE FALSE!!!)
opt.hlsearch = true -- highlight all matches on previous search pattern
-- opt.showmode = false -- we don't need to see things like -- INSERT -- anymore

-- opt.list = true
-- opt.listchars:append("space:⋅")

-- The below settings make Leap's highlighting closer to what you've been
-- used to in Lightspeed.

-- make leap to have lightspeed highlight.
-- NOTE: this is enabled automatically in catpuccin theme but not in kanaqawa
api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" }) -- or some grey
api.nvim_set_hl(0, "LeapMatch", {
  -- For light themes, set to 'black' or similar.
  fg = "white",
  bold = true,
  nocombine = true,
})

-- Of course, specify some nicer shades instead of the default "red" and "blue".
api.nvim_set_hl(0, "LeapLabelPrimary", {
  fg = "red",
  bold = true,
  nocombine = true,
})

api.nvim_set_hl(0, "LeapLabelSecondary", {
  fg = "blue",
  bold = true,
  nocombine = true,
})

-- Try it without this setting first, you might find you don't even miss it.
-- require('leap').opts.highlight_unlabeled_phase_one_targets = true
