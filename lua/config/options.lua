-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt
-- local api = vim.api

vim.opt.fillchars = { eob = " " } -- NOTE: removes trailing '~' in nvim
local is_wsl = vim.fn.has("wsl") == 1

-- NOTE: neovide config
if vim.g.neovide then
  opt.guifont = "CaskaydiaCove Nerd Font:h13.2" -- the font used in graphical neovim applications
  -- opt.guifont = "CaskaydiaCove Nerd Font:h13.9" -- the font used in graphical neovim applications
  -- opt.guifont = "JetBrainsMono Nerd Font:h17.6" -- the font used in graphical neovim applications

  vim.g.neovide_transparency = 0.9 -- NOTE: can be used in windows too but moving neovide to new desktop in windows is not fun just to get transparency and background.
  vim.g.neovide_refresh_rate = 120
  vim.g.neovide_refresh_rate_idle = 5
  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0

  if is_wsl then
    -- vim.g.neovide_fullscreen = true -- very glitchy on wsl. will also make the transparency gone (macos and windows).
  else
    vim.g.neovide_input_macos_alt_is_meta = true -- for option in macos
    vim.g.neovide_input_use_logo = 1 -- enable use of the logo (cmd) key
  end

  -- TODO: fix below keymaps.

  -- Allow clipboard copy paste in neovim
  -- vim.keymap.set("n", "<C-z>", '"+P') -- Paste normal mode -- -- FIX: this work. ctrl v
  vim.keymap.set("n", "<c-V>", '"+P') -- Paste normal mode -- -- FIX: this work. ctrl v (but the keymap is a capital V). however, it is slow. my finding is ctrl V of wezterm is way faster as it is a local func call unlike nvim wsl to winodws.
  vim.keymap.set("v", "<c-C>", '"+y') -- Copy

  -- FIX: change to c-p not working in neovide?
  -- FIX: A-v is not working

  vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
  -- vim.keymap.set("n", "<D-V>", '"+P') -- Paste normal mode
  vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
  vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
  vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode

  -- vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.g.neovide_cursor_vfx_mode = "sonicboom"
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_cursor_vfx_particle_density = 50.0
end

-- -- WSL Clipboard support. doesnt use win32yank as it will have an error when using yanky plugin.
-- if is_wsl then
--   vim.opt.clipboard = "unnamedplus" -- NOTE: to fix the error clip.exe is not an executable

--   -- This is NeoVim's recommended way to solve clipboard sharing if you use WSL
--   -- See: https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl
--   vim.g.clipboard = {
--     name = "WslClipboard",
--     copy = {
--       ["+"] = "clip.exe",
--       ["*"] = "clip.exe",
--     },
--     paste = {
--       ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--       ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--     },
--     cache_enabled = 0,
--   }

--   -- TODO: make p to use the ctrl v as it is way faster when pasting (p is noticeably slow)

--   -- vim.keymap.set({ "n", "v" }, "p", "<c-v>") -- FIX: not working
-- end

-- FIX: cannot be used when su to user in wsl. the win32yank or clip.exe is not executable
-- WSL Clipboard support
if is_wsl then
  vim.opt.clipboard = "unnamed" -- NOTE: to fix the error clip.exe is not an executable
  -- vim.opt.clipboard = "unnamedplus" -- NOTE: to fix the error clip.exe is not an executable
  -- vim.opt.clipboard = "" -- FIX: testing

  -- This is NeoVim's recommended way to solve clipboard sharing if you use WSL
  -- See: https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl
  vim.g.clipboard = {
    name = "win32yank-wsl", -- -- FIX: is faster than above but still slow. its like twice as fast than clip.exe but like 50x slower than when not using unnamedplus
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf", -- NOTE: this is needed by neovide.
      ["*"] = "win32yank.exe -o --lf",
    },
    cache_enabled = 1,
  }
end

-- opt.cursorline = true
opt.list = false -- NOTE: make the > and other symbol to be hidden when the object is commented.
opt.scrolloff = 10 -- minimal number of screen lines to keep above and below the cursor.
opt.sidescrolloff = 10 -- minimal number of screen lines to keep left and right of the cursor.
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
opt.swapfile = false -- creates a swapfile. disable to avoid the anoying prompt
opt.hlsearch = true -- highlight all matches on previous search pattern
-- opt.relativenumber = false
