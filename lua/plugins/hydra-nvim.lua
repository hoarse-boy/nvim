return {
  "anuvyklack/hydra.nvim",
  event = "VeryLazy",
  config = function(_, _)
    local Hydra = require("hydra")
    local cmd = require("hydra.keymap-util").cmd

    -- TODO: create more hydra body?
    -- <leader>H will be just a whichky '+hydra heads'
    -- inside it we can call hydra body that explain about my most used keymaps or the most importent ones.
    -- no print?

    local hint = [[
  _f_: files       _m_: marks
  _o_: old files   _g_: live grep
  _p_: projects    _/_: search in file

  _r_: resume      _u_: undotree
  _h_: vim help    _c_: execute command
  _k_: keymaps     _;_: commands history 
  _O_: options     _?_: search history
 
  _<Enter>_: Telescope           _<Esc>_
]]

    Hydra({
      name = "Telescope",
      hint = hint,
      config = {
        color = "teal",
        invoke_on_body = true,
        hint = {
          position = "middle",
          border = "rounded",
        },
      },
      mode = "n",
      body = "<Leader>H",
      heads = {
        -- TODO: add more and change the hint too
        {
          "f",
          function()
            print("kabom")
          end,
        }, -- FIX: DELETE LATER
        { "g", cmd("Telescope live_grep") },
        { "o", cmd("Telescope oldfiles"), { desc = "recently opened files" } },
        { "h", cmd("Telescope help_tags"), { desc = "vim help" } },
        { "m", cmd("MarksListBuf"), { desc = "marks" } },
        { "k", cmd("Telescope keymaps") },
        { "O", cmd("Telescope vim_options") },
        { "r", cmd("Telescope resume") },
        { "p", cmd("Telescope projects"), { desc = "projects" } },
        { "/", cmd("Telescope current_buffer_fuzzy_find"), { desc = "search in file" } },
        { "?", cmd("Telescope search_history"), { desc = "search history" } },
        { ";", cmd("Telescope command_history"), { desc = "command-line history" } },
        { "c", cmd("Telescope commands"), { desc = "execute command" } },
        { "u", cmd("silent! %foldopen! | UndotreeToggle"), { desc = "undotree" } },
        { "<Enter>", cmd("Telescope"), { exit = true, desc = "list all pickers" } },
        { "<Esc>", nil, { exit = true, nowait = true } },
      },
    })
  end,
}

-- local Hydra = require("hydra")

-- Hydra({
--    name = 'Quick words',
--    config = {
--       color = 'pink',
--       hint = 'statusline',
--    },
--    mode = {'n','x','o'},
--    body = ',',
--    heads = {
--       { 'w',  '<Plug>(smartword-w)'  },
--       { 'b',  '<Plug>(smartword-b)'  },
--       { 'e',  '<Plug>(smartword-e)'  },
--       { 'ge', '<Plug>(smartword-ge)' },
--       { '<Esc>', nil, { exit = true, mode = 'n' } }
--    }
-- })
