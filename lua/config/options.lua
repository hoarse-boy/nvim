-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt
local api = vim.api

-- opt.winbar = "%=%m %f"
opt.cursorline = true
-- opt.cursorcolumn = true
opt.scrolloff = 10 -- minimal number of screen lines to keep above and below the cursor.
opt.sidescrolloff = 10 -- minimal number of screen lines to keep left and right of the cursor.
opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
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
