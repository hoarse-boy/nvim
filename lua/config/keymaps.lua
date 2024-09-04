-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- TODO: use this plugin https://github.com/abeldekat/lazyvim-menu-addon
-- NOTE: put the delete keymaps from the default lazymap keymaps here before overwrite it
-- this is especially usefull if the keymaps will be overwrite by a prefix
local del = vim.keymap.del
local set = vim.keymap.set
local map_opt = { noremap = true, silent = true }

local printf = require("plugins.util.printf").printf

del("n", "<leader>l") -- disable keymap l for lazyvim as it will be used for other lsp keymaps.

-- -- TODO: visual x doesnt put to last yank?

-- keymap to make them to save to void.
-- it should be "_d so uses '' to make the string, else the keymap will not be working
-- "_* will not save to clipboard.
-- p
set("v", "p", '"_dP', map_opt) -- replace currently selected text with default register. without yanking it

-- d
set({ "v", "n" }, "d", '"_d', map_opt) --  will make checkhealth to have a warning. ignore it.
set("n", "dd", '"_dd', map_opt)
set("n", "D", '"_D', map_opt)

-- x
set("n", "x", '"_x', map_opt)

-- c
set({ "v", "n" }, "c", '"_c', map_opt)
set({ "v", "n" }, "C", '"_C', map_opt)

-- faster 'esc' than ctrl+c or 'esc' button.
set("i", "jk", "<esc>l", map_opt) -- added l when escaped to normal mode as to not make the cursor move back 1 column. note: it will add a single column if the cursor is in the first column

-- append a blank line below or above current line. this is usefull to avoid changing mode and generating new line with commented string.
set("n", "<BS>", ":pu! _<cr>", map_opt)
set("n", "<CR>", ":pu _<cr>", map_opt)

-- 'H' and 'L' will be behave like hard to reach '$' and '^'
set({ "v", "n" }, "<S-h>", "^", map_opt)
set("n", "<S-l>", "$", map_opt)
set("v", "<S-l>", "$h", map_opt) -- visual mode $ will add extra space or \n. to avoid that it will be remap as $h

-- undo and redo.
set("n", "U", "<C-r>") -- dont have to use ctrl r to undo again.

-- buffer navigation. this will be used by wezterm wsl and macos. NOTE: Tab in most terminal emulators have the issue of treating that keymap the same as ctrl+i. Tab should not be mapped at all to avoid remapping ctrl+i and changing its behavior. https://superuser.com/questions/770068/in-vim-how-can-i-remap-tab-without-also-remapping-ctrli
-- NOTE: macos + wezterm cannot use cmd-[ or ] so it has differnet keymap than arch linux.
set("n", "<A-]>", "<cmd>BufferLineCycleNext<cr>", { desc = printf("Next Buffer") })
set("n", "<A-[>", "<cmd>BufferLineCyclePrev<cr>", { desc = printf("Prev Buffer") })

-- this will be used by neovide.
-- set("n", "<C-Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = printf"Next buffer" })
-- set("n", "<C-S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = printf"Prev buffer" })

-- TODO: what is this for? remove?
set("n", "<leader>sx", require("telescope.builtin").resume, { noremap = true, silent = true, desc = printf("Resume") })

-- lazy command. -- TODO: use lazyvim-menu-addon to change the leader key, and remove this.
set("n", "<leader>L", "<cmd>:Lazy<cr>", { desc = printf("Lazy") }) -- use L instead of l

-- comments (why uses <Plug> = to avoid go to normal mode)
set("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { desc = printf("Comment Toggle Linewise (Visual)") })
set("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { desc = printf("Comment Toggle Current Line") })

set("n", "<leader>ul", function()
  vim.cmd("set nu signcolumn=yes")
  print("enabled (this is to counter dashboard issue)")
end, { desc = printf("Enable line number and signcolumn"), noremap = true, silent = true })
