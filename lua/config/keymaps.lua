-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- NOTE: put the delete keymaps from the default lazymap keymaps here before overwrite it
-- this is especially usefull if the keymaps will be overwrite by a prefix
local del = vim.keymap.del
del("n", "<leader>l") -- disable keymap l for lazyvim when lsp keymap is not present
del("n", "<leader>xl")
del("n", "<leader>xq")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

local opt = { noremap = true, silent = true }

-- NOTE: it should be "_d so uses '' to make the string, else the keymap will not be working
-- "_* will not save to clipboard.
map({ "v", "n" }, "d", '"_d', opt)
map("n", "dd", '"_dd', opt)

-- NOTE: will not work if lazyvim yanky is installed / enabled
map("v", "p", '"_dP', opt) -- replace currently selected text with default register. without yanking it

map("n", "D", '"_D', opt)
map("n", "x", '"_x', opt)

map({ "v", "n" }, "c", '"_c', opt)
map({ "v", "n" }, "C", '"_C', opt)

-- use better-escape-nvim plugin to make it seamless in animation
map("i", "jk", "<esc>l", opt) -- added l when escaped to normal mode as to not make the cursor move back 1 column. note: it will add a single column if the cursor is in the first column
-- TODO: make this func works
-- map("i", "jk", function()
--   return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<esc>l" or "<esc>"
-- end, opt) -- added l when escaped to normal mode as to not make the cursor move back 1 column. note: it will add a single column if the cursor is in the first column

map("n", "<a-y>", "<cmd>t.<cr>", { desc = "Duplicate line" })
map("v", "y", "ygv<esc>", opt) -- makes the yank not to move back to the first selected line

-- non shift enter and backspace are used for the treesitter's incremental selection
map("n", "<S-BS>", 'O<Esc>^"_D', opt) -- add empty space above. will also perform deletion if the current line is a comment, to make sure it really add empty space
map("n", "<S-CR>", 'o<Esc>^"_D', opt) -- add empty space below. will also perform deletion if the current line is a comment, to make sure it really add empty space

-- 'H' and 'L' will be behave like the annoying '$' and '^'
map({ "v", "n" }, "<S-h>", "^", opt)
map("n", "<S-l>", "$", opt)
map("v", "<S-l>", "$h", opt) -- visual mode $ will add extra space or \n. to avoid that it will be remap as $h

map("n", "U", "<C-r>") -- dont have to use ctrl r to undo again

-- NOTE: for luansip placeholder jumping
-- stylua: ignore
  map({"v", "i" }, "<C-J>", function() local luasnip = require("luasnip") if luasnip.jumpable() then luasnip.jump(1) end end, { desc = "Jump to next placeholder (LuaSnip)",   noremap = true, silent = true })
-- stylua: ignore
  map({"v", "i" }, "<C-I>", function() local luasnip = require("luasnip") if luasnip.jumpable() then luasnip.jump(-1) end end, { desc = "Jump to previous placeholder (LuaSnip)", noremap = true, silent = true })

-- change the lazyvim buffer movement to tab
-- NOTE: importent, Tab in terminal has the issue of treating that keymap the same as ctrl+i
-- so Tab should not be mapped at all to avoid remapping ctrl+i too
-- remapped alt / option and Tab instead
map("n", "<C-Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<C-S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
-- FIX:
-- map("n", "<A-Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
-- map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })

-- map("n", "cp", ':let @" = expand("%:p")<cr>""', { noremap = true, silent = true, desc = "Copy path to register" }) -- added l when escaped to normal mode as to not make the cursor move back 1 line

-- git which-key
map("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle Git Blame (virtual text)" })

map("n", "<leader>sx", require("telescope.builtin").resume, { noremap = true, silent = true, desc = "Resume" })

-- lazy
map("n", "<leader>L", "<cmd>:Lazy<cr>", { desc = "Lazy" }) -- use L instead of l

-- comments (why uses <Plug> = to avoid go to normal mode)
map("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment toggle linewise (visual)" })
map("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { desc = "Comment toggle current line" })

-- disable macro 'q' as nvim-cmp stated that it will disable the plugin when a macro is pressed
map("n", "q", "<cmd>lua print('macro is disabled')<cr>", opt)

-- NOTE: reminder / notes / other cool stuff of nvim or other plugin
-- +notes which-key
-- stylua: ignore
map("n", "<leader>?S", function() local notify = require("notify") notify("use ctrl j / i\nto jump to LuaSnip placeholder", "info", { title = "helper" }) end, { desc = "Jump to previous placeholder (LuaSnip)", noremap = true, silent = true })
-- stylua: ignore
map("n", "<leader>?n", function() local notify = require("notify") notify("ctrl a / x to increase or decrement a number.\ncan also have prefix like 5 ctrl a.\ncan be dot repeated", "info", { title = "helper" }) end, { desc = "Increase / decrement number", noremap = true, silent = true })
-- stylua: ignore
map("n", "<leader>?l", function() local notify = require("notify") notify(":pwd to show location", "info", { title = "helper" }) end, { desc = "pwd", noremap = true, silent = true })
-- stylua: ignore
map("n", "<leader>?s", function() local notify = require("notify") notify("visual block the words, open cmdline, and type sort", "info", { title = "helper" }) end, { desc = "sort list (alphabetical or numerical)", noremap = true, silent = true })
-- stylua: ignore
map("n", "<leader>?r", function() local notify = require("notify") notify("vim cmd search and replace.\n%s/search/replace/\n':%s/' start of the search pattern\n'/' end of the search pattern, beginning of replacement pattern\noptional = '/e' suppress error messages if no match found", "info", { title = "helper" }) end, { desc = "Vim Search Replace Cmd", noremap = true, silent = true })

-- +others keymaps
map("n", "<leader>op", function()
  local path = vim.fn.expand("%:p")
  print(path)
end, { desc = "Copy full path", noremap = true, silent = true })

-- get the full path but with no file name / get the parent dir of that file
map("n", "<leader>oP", function()
  local path = vim.fn.expand("%:p:h")
  print(path)
end, { desc = "Copy full parent dir", noremap = true, silent = true })
