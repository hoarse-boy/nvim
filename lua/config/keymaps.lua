-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- NOTE: put the delete keymaps from the default lazymap keymaps here before overwrite it
-- this is especially usefull if the keymaps will be overwrite by a prefix
local del = vim.keymap.del
del("n", "<leader>l")
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

map("i", "jk", "<esc>l", opt) -- added l when escaped to normal mode as to not make the cursor move back 1 line

-- save global path to "p" and save to clipboard
map(
  "n",
  "cp",
  'o<esc>:let @" = expand("%:p")<cr>""pVxk',
  { noremap = true, silent = true, desc = "Copy path to register" }
) -- added l when escaped to normal mode as to not make the cursor move back 1 line
-- map("n", "cp", ':let @" = expand("%:p")<cr>""', { noremap = true, silent = true, desc = "Copy path to register" }) -- added l when escaped to normal mode as to not make the cursor move back 1 line

-- NOTE: it should be "_d so uses '' to make the string, else the keymap will not be working
-- "_* will not save to clipboard.
map("n", "d", '"_d', opt)
map("v", "d", '"_d', opt) -- lazyvim dont have x in visual mode, but now it has.
map("n", "dd", '"_dd', opt)

map("n", "D", '"_D', opt)
map("n", "x", '"_x', opt)

map("n", "c", '"_c', opt)
map("v", "c", '"_c', opt)
map("n", "C", '"_C', opt)
map("v", "C", '"_C', opt)

-- git which-key
map("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle Git Blame (virtual text)" })

map("n", "<leader>sx", require("telescope.builtin").resume, { noremap = true, silent = true, desc = "Resume" })

-- FIX: move this to go.lua in extras/lang to make it check if the file is golang to shows this key. else remove it
-- use leader lc ? for all lauguage?
-- for example if  the buffer is *.go make it appear as lc of all golang keys
-- and if the file is *.rs make it appear of rust keys only?
-- go-nvim
map("n", "<leader>lgs", "<cmd>GoFillStruct<cr>", { desc = "Go Fill Struct" })
map("n", "<leader>lgf", "<cmd>GoFillSwitch<cr>", { desc = "Go Fill Switch" })
map("n", "<leader>lgt", "<cmd>GoAddTag<cr>", { desc = "Go Add Tags" })
map("n", "<leader>lgr", "<cmd>GoRmTag<cr>", { desc = "Go Remove Tags" })
map("n", "<leader>lgT", "<cmd>GoTestFun<cr>", { desc = "Go Test a Function" })
map("n", "<leader>lgA", "<cmd>GoTestPkg<cr>", { desc = "Go Test Package" })
map("n", "<leader>lge", "<cmd>GoIfErr<cr>", { desc = "Go Auto Generate 'if err'" })
map("n", "<leader>lgc", "<cmd>GoCmt<cr>", { desc = "Go Generate Func Comments" })
map("n", "<leader>lgm", "<cmd>Gomvp<cr>", { desc = "Go Rename Module name" })
map("n", "<leader>lgm", "<cmd>GoFixPlurals<cr>", { desc = "Go Fix Redundant Func Params" }) -- not working?

-- lazy
map("n", "<leader>L", "<cmd>:Lazy<cr>", { desc = "Lazy" })

-- harpoon
map("n", "<leader>hm", "<cmd>lua require('harpoon.mark').add_file()<cr>", { desc = "Mark for Harpoon" })
map("n", "<leader>ht", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", { desc = "Toggle Quick Menu" })
map("n", "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<cr>", { desc = "Go to next" })
map("n", "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", { desc = "Go to previous" }) -- FIX: not working?

-- other keymaps
map("n", "<leader>H", "<cmd>nohlsearch<CR>", { desc = "No Highlight" })
map("n", "<leader>st", "<cmd>TodoTelescope<CR>", { desc = "Todo Telescope" })

-- comments (why uses <Plug> = to avoid go to normal mode)
map("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment toggle linewise (visual)" })
map("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { desc = "Comment toggle current line" })
