local printf = require("plugins.util.printf").printf

return {
  {
    "theprimeagen/harpoon",
    event = "VeryLazy",
    keys = {
      { "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = printf("Mark a File") },
      { "<leader>hT", ":Telescope harpoon marks<cr>", desc = printf("Open Telescope Harpoon") },
      { "<leader>ht", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = printf("Open Quick Menu") }, -- NOTE: also for some golang repo which has many go.mod in a single git file it will not be able to show the marked files
      -- { "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<cr>", desc = printf"Go to next" },
      -- { "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", desc = printf"Go to previous" },
    },
    config = function(_, opts)
      require("harpoon").setup({
        -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
        save_on_toggle = false,

        -- saves the harpoon file upon every change. disabling is unrecommended.
        save_on_change = true,

        -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
        enter_on_sendcmd = false,

        -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
        tmux_autoclose_windows = false,

        -- filetypes that you want to prevent from adding to the harpoon list menu.
        excluded_filetypes = { "harpoon" },

        -- set marks specific to each git branch inside git repository
        mark_branch = false,

        -- enable tabline with harpoon marks
        tabline = false,
        tabline_prefix = "   ",
        tabline_suffix = "   ",
      })
      require("telescope").load_extension("harpoon")
    end,
  },

  {
    "folke/which-key.nvim",
    opts = function(_, _)
      local wk = require("which-key")
      local mapping = {
        { "<leader>h", icon = "󱡀", group = printf("harpoon"), mode = "n" },
      }
      wk.add(mapping)
    end,
  },
}

-- FIX: harpoon2 still buggy.
-- when opening the file in harpoon list it will not append to the same buffer. opening file using neo-tree will append the file into buffer list.
-- when opening harpoon list and the current buffer is open it will go to that position of the same file name in harppon list. which harpoon2 cannot do atm.
-- return {
--   "theprimeagen/harpoon",
--   event = "VeryLazy",
--   branch = "harpoon2", -- will be merge to master in upcoming months.
--   commit = "18bf9fbab6e93b07919e060a817c9b94adb710a4", -- FIX: harpoon not working.
--   dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },

--   config = function(_, opts)
--     -- add to which key
--     local wk = require("which-key")
--     wk.setup(opts)
--     local keymaps = {
--       mode = { "n" },
--       ["<leader>h"] = { name = "+harpoon" },
--     }
--     wk.register(keymaps, opts)

--     local harpoon = require("harpoon")

--     -- REQUIRED
--     harpoon:setup({})

--     local notify = require("notify")

--     vim.keymap.set("n", "<leader>ha", function()
--       harpoon:list():append()
--       notify("append a file to harpoon list", "info", { title = "Harpoon" })
--     end, { desc = printf"Append File to Harpoon List" })

--     -- stylua: ignore
--     vim.keymap.set("n", "<leader>ht", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = printf"Toggle Harpoon List" })
--     -- stylua: ignore
--     vim.keymap.set("n", "<leader>hh", function() harpoon:list():select(1) end, { desc = printf"Go to Harpoon File no. 1" })
--     -- stylua: ignore
--     vim.keymap.set("n", "<leader>hj", function() harpoon:list():select(2) end, { desc = printf"Go to Harpoon File no. 2" })
--     -- stylua: ignore
--     vim.keymap.set("n", "<leader>hk", function() harpoon:list():select(3) end, { desc = printf"Go to Harpoon File no. 3" })
--     -- stylua: ignore
--     vim.keymap.set("n", "<leader>hl", function() harpoon:list():select(4) end, { desc = printf"Go to Harpoon File no. 4" })

--     -- Toggle previous & next buffers stored within Harpoon list
--     -- stylua: ignore
--     vim.keymap.set("n", "<A-S-P>", function() harpoon:list():prev() end, { desc = printf"Go to Previous Harpoon File" })
--     -- stylua: ignore
--     vim.keymap.set("n", "<A-S-N>", function() harpoon:list():next() end, { desc = printf"Go to Next Harpoon File" })

--     -- basic telescope configuration
--     local conf = require("telescope.config").values
--     local function toggle_telescope(harpoon_files)
--       local file_paths = {}
--       for _, item in ipairs(harpoon_files.items) do
--         table.insert(file_paths, item.value)
--       end

--       require("telescope.pickers")
--         .new({}, {
--           prompt_title = "Harpoon",
--           finder = require("telescope.finders").new_table({
--             results = file_paths,
--           }),
--           previewer = conf.file_previewer({}),
--           sorter = conf.generic_sorter({}),
--         })
--         :find()
--     end

--     -- stylua: ignore
--     vim.keymap.set("n", "<leader>hT", function() toggle_telescope(harpoon:list()) end, { desc = printf"Toggle Harpoon List (Telescope)" })
--   end,
-- }
