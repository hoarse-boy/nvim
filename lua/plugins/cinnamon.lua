return {
  "declancm/cinnamon.nvim",
  -- enabled = false,
  event = "VeryLazy",
  config = function()
    -- will have different setting for neovide. as the delay is noticable bigger in it
    if vim.g.neovide then
      require("cinnamon").setup({
        -- KEYMAPS:
        default_keymaps = true, -- Create default keymaps.
        -- NOTE: extra_keymaps true makes golang buggy. but rust is fine. the cause of keymap for gg and gG
        extra_keymaps = false, -- Create extra keymaps.
        extended_keymaps = false, -- Create extended keymaps.
        override_keymaps = false, -- The plugin keymaps will override any existing keymaps.

        -- OPTIONS:
        -- NOTE: use this for a better { and } motion
        always_scroll = true, -- Scroll the cursor even when the window hasn't scrolled.
        centered = true, -- Keep cursor centered in window when using window scrolling.
        disabled = false, -- Disables the plugin.
        default_delay = 7, -- The default delay (in ms) between each line when scrolling.
        -- NOTE: sometimes causing cursor to diseaper completely?
        hide_cursor = false, -- Hide the cursor while scrolling. Requires enabling termguicolors!
        horizontal_scroll = false, -- Enable smooth horizontal scrolling when view shifts left or right.
        -- NOTE: use the max lenght and limit to make search with n to not have massive delay in animation
        -- max_length = 50,
        max_length = 50, -- Maximum length (in ms) of a command. The line delay will be
        -- max_length = -1, -- Maximum length (in ms) of a command. The line delay will be
        -- re-calculated. Setting to -1 will disable this option.
        scroll_limit = 50, -- Max number of lines moved before scrolling is skipped. Setting
        -- to -1 will disable this option.
      })
    else
      require("cinnamon").setup({
        -- KEYMAPS:
        default_keymaps = true, -- Create default keymaps.
        -- NOTE: extra_keymaps true makes golang buggy. but rust is fine. the cause of keymap for gg and gG
        extra_keymaps = false, -- Create extra keymaps.
        extended_keymaps = false, -- Create extended keymaps.
        override_keymaps = false, -- The plugin keymaps will override any existing keymaps.

        -- OPTIONS:
        -- NOTE: use this for a better { and } motion
        always_scroll = true, -- Scroll the cursor even when the window hasn't scrolled.
        centered = true, -- Keep cursor centered in window when using window scrolling.
        disabled = false, -- Disables the plugin.
        default_delay = 3, -- The default delay (in ms) between each line when scrolling.
        -- NOTE: sometimes causing cursor to diseaper completely?
        hide_cursor = false, -- Hide the cursor while scrolling. Requires enabling termguicolors!
        -- horizontal_scroll = false, -- Enable smooth horizontal scrolling when view shifts left or right.
        -- NOTE: use the max lenght and limit to make search with n to not have massive delay in animation
        -- max_length = -1, -- Maximum length (in ms) of a command. The line delay will be
        max_length = 50, -- Maximum length (in ms) of a command. The line delay will be
        -- re-calculated. Setting to -1 will disable this option.
        scroll_limit = 50, -- Max number of lines moved before scrolling is skipped. Setting
        -- to -1 will disable this option.
      })
    end
    -- Paragraph movements:
    vim.keymap.set({ "n", "x", "v" }, "{", "<Cmd>lua Scroll('{')<CR>")
    vim.keymap.set({ "n", "x", "v" }, "}", "<Cmd>lua Scroll('}')<CR>")

    -- Previous/next search result:
    vim.keymap.set("n", "n", "<Cmd>lua Scroll('n', 1)<CR>")
    vim.keymap.set("n", "N", "<Cmd>lua Scroll('N', 1)<CR>")
    vim.keymap.set("n", "*", "<Cmd>lua Scroll('*', 1)<CR>")
    vim.keymap.set("n", "#", "<Cmd>lua Scroll('#', 1)<CR>")
    vim.keymap.set("n", "g*", "<Cmd>lua Scroll('g*', 1)<CR>")
    vim.keymap.set("n", "g#", "<Cmd>lua Scroll('g#', 1)<CR>")

    -- Start/end of file and line number movements:
    -- NOTE: makes golang buggy
    -- vim.keymap.set({ "n", "x" }, "gg", "<Cmd>lua Scroll('gg')<CR>")
    -- vim.keymap.set({ "n", "x" }, "G", "<Cmd>lua Scroll('G', 0, 1)<CR>")

    -- Screen scrolling:
    vim.keymap.set("n", "zz", "<Cmd>lua Scroll('zz', 0, 1)<CR>")
    vim.keymap.set("n", "zt", "<Cmd>lua Scroll('zt', 0, 1)<CR>")
    vim.keymap.set("n", "zb", "<Cmd>lua Scroll('zb', 0, 1)<CR>")
    vim.keymap.set("n", "z.", "<Cmd>lua Scroll('z.', 0, 1)<CR>")
    vim.keymap.set("n", "z<CR>", "<Cmd>lua Scroll('zt^', 0, 1)<CR>")
    vim.keymap.set("n", "z-", "<Cmd>lua Scroll('z-', 0, 1)<CR>")
    vim.keymap.set("n", "z^", "<Cmd>lua Scroll('z^', 0, 1)<CR>")
    vim.keymap.set("n", "z+", "<Cmd>lua Scroll('z+', 0, 1)<CR>")
    vim.keymap.set("n", "<C-y>", "<Cmd>lua Scroll('<C-y>', 0, 1)<CR>")
    vim.keymap.set("n", "<C-e>", "<Cmd>lua Scroll('<C-e>', 0, 1)<CR>")

    -- SCROLL_WHEEL_KEYMAPS:

    vim.keymap.set({ "n", "x" }, "<ScrollWheelUp>", "<Cmd>lua Scroll('<ScrollWheelUp>')<CR>")
    vim.keymap.set({ "n", "x" }, "<ScrollWheelDown>", "<Cmd>lua Scroll('<ScrollWheelDown>')<CR>")
  end,
}

-- DEFAULT_KEYMAPS:

-- -- Half-window movements:
-- vim.keymap.set({ 'n', 'x' }, '<C-u>', "<Cmd>lua Scroll('<C-u>', 1, 1)<CR>")
-- vim.keymap.set({ 'n', 'x' }, '<C-d>', "<Cmd>lua Scroll('<C-d>', 1, 1)<CR>")

-- -- Page movements:
-- vim.keymap.set({ 'n', 'x' }, '<C-b>', "<Cmd>lua Scroll('<C-b>', 1, 1)<CR>")
-- vim.keymap.set({ 'n', 'x' }, '<C-f>', "<Cmd>lua Scroll('<C-f>', 1, 1)<CR>")
-- vim.keymap.set({ 'n', 'x' }, '<PageUp>', "<Cmd>lua Scroll('<C-b>', 1, 1)<CR>")
-- vim.keymap.set({ 'n', 'x' }, '<PageDown>', "<Cmd>lua Scroll('<C-f>', 1, 1)<CR>")

-- -- EXTRA_KEYMAPS:

-- -- Start/end of file and line number movements:
-- vim.keymap.set({ 'n', 'x' }, 'gg', "<Cmd>lua Scroll('gg')<CR>")
-- vim.keymap.set({ 'n', 'x' }, 'G', "<Cmd>lua Scroll('G', 0, 1)<CR>")

-- -- Start/end of line:
-- vim.keymap.set({ 'n', 'x' }, '0', "<Cmd>lua Scroll('0')<CR>")
-- vim.keymap.set({ 'n', 'x' }, '^', "<Cmd>lua Scroll('^')<CR>")
-- vim.keymap.set({ 'n', 'x' }, '$', "<Cmd>lua Scroll('$', 0, 1)<CR>")

-- -- Paragraph movements:
-- vim.keymap.set({ 'n', 'x' }, '{', "<Cmd>lua Scroll('{')<CR>")
-- vim.keymap.set({ 'n', 'x' }, '}', "<Cmd>lua Scroll('}')<CR>")

-- -- Previous/next search result:
-- vim.keymap.set('n', 'n', "<Cmd>lua Scroll('n', 1)<CR>")
-- vim.keymap.set('n', 'N', "<Cmd>lua Scroll('N', 1)<CR>")
-- vim.keymap.set('n', '*', "<Cmd>lua Scroll('*', 1)<CR>")
-- vim.keymap.set('n', '#', "<Cmd>lua Scroll('#', 1)<CR>")
-- vim.keymap.set('n', 'g*', "<Cmd>lua Scroll('g*', 1)<CR>")
-- vim.keymap.set('n', 'g#', "<Cmd>lua Scroll('g#', 1)<CR>")

-- -- Previous/next cursor location:
-- vim.keymap.set('n', '<C-o>', "<Cmd>lua Scroll('<C-o>', 1)<CR>")
-- vim.keymap.set('n', '<C-i>', "<Cmd>lua Scroll('1<C-i>', 1)<CR>")

-- -- Screen scrolling:
-- vim.keymap.set('n', 'zz', "<Cmd>lua Scroll('zz', 0, 1)<CR>")
-- vim.keymap.set('n', 'zt', "<Cmd>lua Scroll('zt', 0, 1)<CR>")
-- vim.keymap.set('n', 'zb', "<Cmd>lua Scroll('zb', 0, 1)<CR>")
-- vim.keymap.set('n', 'z.', "<Cmd>lua Scroll('z.', 0, 1)<CR>")
-- vim.keymap.set('n', 'z<CR>', "<Cmd>lua Scroll('zt^', 0, 1)<CR>")
-- vim.keymap.set('n', 'z-', "<Cmd>lua Scroll('z-', 0, 1)<CR>")
-- vim.keymap.set('n', 'z^', "<Cmd>lua Scroll('z^', 0, 1)<CR>")
-- vim.keymap.set('n', 'z+', "<Cmd>lua Scroll('z+', 0, 1)<CR>")
-- vim.keymap.set('n', '<C-y>', "<Cmd>lua Scroll('<C-y>', 0, 1)<CR>")
-- vim.keymap.set('n', '<C-e>', "<Cmd>lua Scroll('<C-e>', 0, 1)<CR>")

-- -- Horizontal screen scrolling:
-- vim.keymap.set('n', 'zH', "<Cmd>lua Scroll('zH')<CR>")
-- vim.keymap.set('n', 'zL', "<Cmd>lua Scroll('zL')<CR>")
-- vim.keymap.set('n', 'zs', "<Cmd>lua Scroll('zs')<CR>")
-- vim.keymap.set('n', 'ze', "<Cmd>lua Scroll('ze')<CR>")
-- vim.keymap.set('n', 'zh', "<Cmd>lua Scroll('zh', 0, 1)<CR>")
-- vim.keymap.set('n', 'zl', "<Cmd>lua Scroll('zl', 0, 1)<CR>")

-- -- EXTENDED_KEYMAPS:

-- -- Up/down movements:
-- vim.keymap.set({ 'n', 'x' }, 'k', "<Cmd>lua Scroll('k', 0, 1)<CR>")
-- vim.keymap.set({ 'n', 'x' }, 'j', "<Cmd>lua Scroll('j', 0, 1)<CR>")
-- vim.keymap.set({ 'n', 'x' }, '<Up>', "<Cmd>lua Scroll('k', 0, 1)<CR>")
-- vim.keymap.set({ 'n', 'x' }, '<Down>', "<Cmd>lua Scroll('j', 0, 1)<CR>")

-- -- Left/right movements:
-- vim.keymap.set({ 'n', 'x' }, 'h', "<Cmd>lua Scroll('h', 0, 1)<CR>")
-- vim.keymap.set({ 'n', 'x' }, 'l', "<Cmd>lua Scroll('l', 0, 1)<CR>")
-- vim.keymap.set({ 'n', 'x' }, '<Left>', "<Cmd>lua Scroll('h', 0, 1)<CR>")
-- vim.keymap.set({ 'n', 'x' }, '<Right>', "<Cmd>lua Scroll('l', 0, 1)<CR>")

-- -- SCROLL_WHEEL_KEYMAPS:

-- vim.keymap.set({ 'n', 'x' }, '<ScrollWheelUp>', "<Cmd>lua Scroll('<ScrollWheelUp>')<CR>")
-- vim.keymap.set({ 'n', 'x' }, '<ScrollWheelDown>', "<Cmd>lua Scroll('<ScrollWheelDown>')<CR>")

-- -- LSP_KEYMAPS:

-- -- LSP go-to-definition:
-- vim.keymap.set('n', 'gd', "<Cmd>lua Scroll('definition')<CR>")

-- -- LSP go-to-declaration:
-- vim.keymap.set('n', 'gD', "<Cmd>lua Scroll('declaration')<CR>")
