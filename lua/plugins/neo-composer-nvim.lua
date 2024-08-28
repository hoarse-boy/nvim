local os_util = require("plugins.util.check-os")
local os_name = os_util.get_os_name()
local enabled_plugin = os_name == os_util.LINUX

if not enabled_plugin then
  return {} -- macos neocomposer is super slow when quiting nvim because of sqlite.
else
  return {
    {
      "ecthelionvi/NeoComposer.nvim",
      event = "VeryLazy",
      dependencies = { "kkharji/sqlite.lua", "nvim-telescope/telescope.nvim" },
      config = function(_, _)
        require("NeoComposer").setup({
          keymaps = {
            play_macro = "Q",
            yank_macro = "yq",
            stop_macro = "cq",
            toggle_record = "q",
            cycle_next = "gqn", -- NOTE: disable it the default c-n as it is used by supermaven.
            cycle_prev = "gqp",
            toggle_macro_menu = "<m-q>",
          },
        })
        require("telescope").load_extension("macros")
      end,
    },

    {
      "folke/which-key.nvim",
      opts = function(_, _)
        local printf = require("plugins.util.printf").printf
        local wk = require("which-key")
        local mapping = {
          { "<leader>M", "<cmd>Telescope macros<cr>", group = printf("NeoComposer (macro)"), icon = "" },
        }
        wk.add(mapping)
      end,
    },

    {
      "nvim-lualine/lualine.nvim",
      optional = true,
      event = "VeryLazy",
      opts = function(_, opts)
        table.remove(opts.sections.lualine_x, 2)                                             -- remove the 2nd element responsible for the recording macro.
        table.insert(opts.sections.lualine_x, 2, require("NeoComposer.ui").status_recording) -- add NeoComposer status recording.
      end,
    },
  }
end
