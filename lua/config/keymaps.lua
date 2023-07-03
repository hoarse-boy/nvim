-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- NOTE: put the delete keymaps from the default lazymap keymaps here before overwrite it
-- this is especially usefull if the keymaps will be overwrite by a prefix
local del = vim.keymap.del
del("n", "<leader>l") -- disable keymap l for lazyvim when lsp keymap is not present

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

map("v", "p", '"_dP', opt) -- replace currently selected text with default register. without yanking it

map("n", "D", '"_D', opt)
map("n", "x", '"_x', opt)

map({ "v", "n" }, "c", '"_c', opt)
map({ "v", "n" }, "C", '"_C', opt)

map("i", "jk", "<esc>l", opt) -- added l when escaped to normal mode as to not make the cursor move back 1 column. note: it will add a single column if the cursor is in the first column

map("n", "<a-y>", "<cmd>t.<cr>", { desc = "Duplicate line" })
map("v", "y", "ygv<esc>", opt) -- makes the yank not to move back to the first selected line

-- non shift enter and backspace are used for the treesitter's incremental selection
map("n", "<S-BS>", "O<Esc>^D", opt) -- add empty space above. will also perform deletion if the current line is a comment, to make sure it really add empty space
map("n", "<S-CR>", "o<Esc>^D", opt) -- add empty space below. will also perform deletion if the current line is a comment, to make sure it really add empty space

-- 'H' and 'L' will be behave like the annoying '$' and '^'
map({ "v", "n" }, "<S-h>", "^", opt)
map("n", "<S-l>", "$", opt)
map("v", "<S-l>", "$h", opt) -- visual mode $ will add extra space or \n. to avoid that it will be remap as $h

map("n", "U", "<C-r>") -- dont have to use ctrl r to undo again

-- change the lazyvim buffer movement to tab
map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })

-- stylua: ignore
-- save global path to "p" and save to clipboard
map( "n", "cp", 'o<esc>:let @" = expand("%:p")<cr>""pVxk', { noremap = true, silent = true, desc = "Copy path to register" }) -- added l when escaped to normal mode as to not make the cursor move back 1 line
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
