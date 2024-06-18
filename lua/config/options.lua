-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt
local set_keymap = vim.keymap.set

vim.opt.fillchars = { eob = " " } -- NOTE: removes trailing '~' in nvim

-- NOTE: neovide config
if vim.g.neovide then
  opt.guifont = "JetBrainsMono Nerd Font:h10" -- the font used in graphical neovim applications

  vim.g.neovide_scale_factor = 1.0
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(1.25)
  end)
  vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1 / 1.25)
  end)

  vim.g.neovide_transparency = 0.7 -- NOTE: can be used in windows too but moving neovide to new desktop in windows is not fun just to get transparency and background.
  vim.g.neovide_refresh_rate = 75
  vim.g.neovide_refresh_rate_idle = 5
  vim.g.neovide_padding_top = 4
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 6
  vim.g.neovide_input_macos_alt_is_meta = true -- for option in macos
  vim.g.neovide_input_use_logo = 1             -- enable use of the logo (cmd) key

  -- TODO: fix below keymaps.

  -- Allow clipboard copy paste in neovim
  -- set_keymap("n", "<C-z>", '"+P') -- Paste normal mode -- -- FIX: this work. ctrl v
  -- set_keymap("n", "<c-V>", '"+P') -- Paste normal mode
  set_keymap("v", "<c-C>", '"+y') -- Copy

  -- FIX: change to c-p not working in neovide?
  -- FIX: A-v is not working

  set_keymap("n", "<D-s>", ":w<CR>")      -- Save
  -- set_keymap("n", "<D-V>", '"+P') -- Paste normal mode
  set_keymap("v", "<D-v>", '"+P')         -- Paste visual mode
  set_keymap("c", "<D-v>", "<C-R>+")      -- Paste command mode
  set_keymap("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode

  -- vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.g.neovide_cursor_vfx_mode = "sonicboom"
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_cursor_vfx_particle_density = 50.0
end

-- opt.cursorline = true
opt.list = false        -- NOTE: make the > and other symbol to be hidden when the object is commented.
opt.scrolloff = 10      -- minimal number of screen lines to keep above and below the cursor.
opt.sidescrolloff = 10  -- minimal number of screen lines to keep left and right of the cursor.
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited.
opt.swapfile = false    -- creates a swapfile. disable to avoid the annoying prompt.
opt.hlsearch = true     -- highlight all matches on previous search pattern.
opt.relativenumber = false

vim.g.autoformat = false -- disable auto format. use <leader>cf to format.
