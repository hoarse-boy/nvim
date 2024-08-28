local opt = vim.opt
local set_keymap = vim.keymap.set

local M = {}

M.setup = function()
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

    vim.g.neovide_transparency = 0.9 -- NOTE: can be used in windows too but moving neovide to new desktop in windows is not fun just to get transparency and background.
    vim.g.neovide_refresh_rate = 75
    vim.g.neovide_refresh_rate_idle = 5
    vim.g.neovide_padding_top = 4
    vim.g.neovide_padding_bottom = 0
    vim.g.neovide_padding_right = 0
    vim.g.neovide_padding_left = 6

    -- vim.g.neovide_input_macos_alt_is_meta = true -- for option in macos
    -- vim.g.neovide_input_use_logo = 1             -- enable use of the logo (cmd) key

    -- TODO: fix below keymaps.

    -- Allow clipboard copy paste in neovim

    -- stylua: ignore
    set_keymap("n", "<c-v>", function() vim.api.nvim_paste(vim.fn.getreg('+'), true, -1) end)
    -- set_keymap("n", "<c-shift-v>", '"+P') -- Paste normal mode
    set_keymap("v", "<c-C>", '"+y') -- Copy

    set_keymap("n", "<D-s>", ":w<CR>") -- Save
    -- set_keymap("n", "<D-V>", '"+P') -- Paste normal mode
    set_keymap("v", "<D-v>", '"+P') -- Paste visual mode
    set_keymap("c", "<D-v>", "<C-R>+") -- Paste command mode
    set_keymap("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode

    -- vim.g.neovide_cursor_vfx_mode = "sonicboom"
    vim.g.neovide_cursor_vfx_mode = "railgun"
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_cursor_vfx_particle_density = 25.0
    vim.g.neovide_cursor_vfx_opacity = 200.0
    vim.g.neovide_cursor_vfx_particle_lifetime = 1.1
    vim.g.neovide_cursor_vfx_particle_curl = 1.0
    vim.g.neovide_cursor_vfx_particle_speed = 10.0
  end
end

return M
