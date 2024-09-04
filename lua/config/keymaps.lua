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
-- del("n", "<leader>xl")
-- del("n", "<leader>xq")

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

-- TODO: remove this and put it in a readme.md that can be called using kiwi.nvim?
-- NOTE: reminder / notes / other cool stuff of nvim or other plugin
-- +notes which-key
-- stylua: ignore
set("n", "<leader>?S",
  function()
    local notify = require("notify")
    notify("use ctrl j / i\nto jump to LuaSnip placeholder", "info", { title = "helper" })
  end, { desc = printf "Jump to previous placeholder (LuaSnip)", noremap = true, silent = true })

set("n", "<leader>?n", function()
  local notify = require("notify")
  notify("ctrl a / x to increase or decrement a number.\ncan also have prefix like 5 ctrl a.\ncan be dot repeated", "info", { title = "helper" })
end, { desc = printf("Increase / decrement number"), noremap = true, silent = true })

set("n", "<leader>?l", function()
  local notify = require("notify")
  notify(":pwd to show location", "info", { title = "helper" })
end, { desc = printf("pwd"), noremap = true, silent = true })

set("n", "<leader>?s", function()
  local notify = require("notify")
  notify("visual block the words, open cmdline, and type sort", "info", { title = "helper" })
end, { desc = printf("sort list (alphabetical or numerical)"), noremap = true, silent = true })

set("n", "<leader>?r", function()
  local notify = require("notify")
  notify("vim cmd search and replace.\n%s/search/replace/\n':%s/' start of the search pattern\n'/' end of the search pattern, beginning of replacement pattern\noptional = '/e' suppress error messages if no match found", "info", { title = "helper" })
end, { desc = printf("Vim Search Replace Cmd"), noremap = true, silent = true })

set("n", "<leader>?y", function()
  local notify = require("notify")
  notify("use 'yig' to yank the word under the cursor.", "info", { title = "helper" })
end, { desc = printf("mini.ai to yank entire buffer content"), noremap = true, silent = true })

-- FIX: commented this for now. will be removed in the future. <space>o will be used for obsidian and this notes will be in obsidian vault and will be searchd by telescope.
-- -- +others keymaps
-- set("n", "<leader>op", function()
--   local path = vim.fn.expand("%:p")
--   print(path)
-- end, { desc = printf"Copy full path", noremap = true, silent = true })

-- -- get the full path but with no file name / get the parent dir of that file
-- set("n", "<leader>oP", function()
--   local path = vim.fn.expand("%:p:h")
--   print(path)
-- end, { desc = printf"Copy full parent dir", noremap = true, silent = true })

-- TODO: remove this if the lazyVim.format is working again. this is a fix for lua formatting. other formatting is working fine.
set({ "n", "v" }, "<leader>cf", "<cmd>lua vim.lsp.buf.format()<cr>", { desc = printf("Format") })

set("n", "<leader>ul", function()
  vim.cmd("set nu signcolumn=yes")
  print("enabled (this is to counter dashboard issue)")
end, { desc = printf("Enable line number and signcolumn"), noremap = true, silent = true })
