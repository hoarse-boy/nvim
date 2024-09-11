-- NOTE: go back to neo-tree to use the git explorer and the plugin has fixed the bug.

local printf = require("plugins.util.printf").printf
local disable_plugin = true

if disable_plugin then
  return {}
end

return {
  {
    "nvim-tree/nvim-tree.lua",
    -- use this to fix the bug, if entering the dashboard and click s to load session. nvim will be unable to open the nvim-tree. don't use cmd or lazy = true.
    -- FIX: there is one time NvimTreeToggle not working after loading session.
    event = "VeryLazy",
    -- lazy = false, -- NOTE: if the bug persist, uncomment this and comment VeryLazy event.
    -- enabled = false, -- disabled plugin
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", mode = "n", desc = printf("Nvim-tree (Explorer)"), silent = true, noremap = true },
    },
    config = function()
      local api = require("nvim-tree.api")

      local function edit_or_open()
        local node = api.tree.get_node_under_cursor()

        if node.nodes ~= nil then
          -- expand or collapse folder
          api.node.open.edit()
        else
          -- open file
          api.node.open.edit()
          -- Close the tree if file was opened
          api.tree.close()
        end
      end

      -- open as vsplit on current node
      local function vsplit_preview()
        local node = api.tree.get_node_under_cursor()

        if node.nodes ~= nil then
          -- expand or collapse folder
          api.node.open.edit()
        else
          -- open file as vsplit
          api.node.open.vertical()
        end

        -- Finally refocus on tree if it was lost
        api.tree.focus()
      end

      local function on_attach(bufnr)
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)
        -- NOTE: here are the list of other usefull keybinds
        -- C is used to toggle collapse all.
        -- H is used to toggle hidden files.

        -- on_attach
        vim.keymap.set("n", "l", edit_or_open, opts("Edit Or Open"))
        vim.keymap.set("n", "L", vsplit_preview, opts("Vsplit Preview"))
        vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
        -- vim.keymap.set("n", "c", api.fs.copy.absolute_path, opts("Yank Path"))
        -- vim.keymap.set("n", "/", api.live_filter.start, opts("Filter")) -- NOTE: nvim filter is buggy.
        vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
      end

      -- TODO: find a way to run require("dapui").open({ reset = true }) when toggling nvim tree.
      -- local Event = api.events.Event
      -- api.events.subscribe(Event.TreeClose, function()
      --   if require("dap").session() then
      --     require("dapui").open({ reset = true })
      --   end
      -- end)

      require("nvim-tree").setup({
        on_attach = on_attach,
        hijack_cursor = true, -- NOTE: very usefull to avoid catpuccin and other theme highlighting the symbol '>' when the cursor is on it.
        auto_reload_on_write = true,
        disable_netrw = true, -- already disabled by lazyvim.
        hijack_netrw = true,
        hijack_unnamed_buffer_when_opening = false,

        -- NOTE: make the nvim-tree shows the current file's directory like neo-tree behavior.
        root_dirs = { ".git", "package.json", "Cargo.toml", "init.lua", "go.mod", "License", "tsconfig.json", "Makefile", ".gitignore", ".env", ".dockerignore", "Dockerfile", "composer.json" },
        prefer_startup_root = true,
        update_focused_file = {
          enable = true,
          update_root = true, -- update the root dir when opening file that has different root dir. it is not working like neo-tree unless prefer_startup_root is true and root_dirs has the correct file to identify it as a root.
          ignore_list = {},
        },
        respect_buf_cwd = true,
        sync_root_with_cwd = true,

        reload_on_bufenter = false,
        select_prompts = false,
        sort = {
          sorter = "name",
          folders_first = true,
          files_first = false,
        },

        view = {
          centralize_selection = false,
          -- centralize_selection = true,
          cursorline = true,
          debounce_delay = 15,
          side = "left",
          preserve_window_proportions = false,
          number = false,
          relativenumber = false,
          signcolumn = "yes",
          width = 40,
          float = {
            enable = false,
            quit_on_focus_loss = true,
            open_win_config = {
              relative = "editor",
              border = "rounded",
              width = 30,
              height = 30,
              row = 1,
              col = 1,
            },
          },
        },

        renderer = {
          group_empty = true,
          root_folder_label = ":t",
          -- root_folder_label = true,
          -- root_folder_label = false,
          -- root_folder_label = ":~:s?$?/..?",
          highlight_modified = "all",
          highlight_git = true,
          add_trailing = false,
          full_name = false,
          -- indent_width = 0,
          indent_width = 2,
          special_files = { "Cargo.toml", "Makefile", "makefile", "README.md", "readme.md", "Dockerfile", "dockerfile", "go.mod", "go.work" },
          symlink_destination = true,
          highlight_diagnostics = "none",
          highlight_opened_files = "all",
          highlight_bookmarks = "none",
          highlight_clipboard = "name",
          indent_markers = {
            enable = true,
            inline_arrows = true,
            icons = {
              corner = "└",
              edge = "│",
              item = "│",
              bottom = "─",
              none = " ",
            },
          },
          icons = {
            web_devicons = {
              file = {
                enable = true,
                color = true,
              },
              folder = {
                enable = true,
                color = true,
              },
            },
            git_placement = "after",
            modified_placement = "after",
            diagnostics_placement = "before",
            bookmarks_placement = "before",
            -- diagnostics_placement = "signcolumn",
            -- bookmarks_placement = "signcolumn",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
              modified = true,
              diagnostics = true,
              bookmarks = true,
            },
            glyphs = {
              default = "",
              symlink = "",
              bookmark = "󰆤",
              modified = "●",
              folder = {
                arrow_closed = "",
                arrow_open = "",
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "",
                symlink_open = "",
              },
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
          },
        },

        hijack_directories = {
          enable = false,
          auto_open = false,
        },

        system_open = {
          cmd = "",
          args = {},
        },

        git = {
          enable = true,
          show_on_dirs = true,
          show_on_open_dirs = true,
          disable_for_dirs = {},
          timeout = 400,
          cygwin_support = false,
        },

        diagnostics = {
          enable = false,
          show_on_dirs = false,
          show_on_open_dirs = true,
          debounce_delay = 50,
          severity = {
            min = vim.diagnostic.severity.HINT,
            max = vim.diagnostic.severity.ERROR,
          },
          icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
          },
        },

        modified = {
          enable = false,
          show_on_dirs = true,
          show_on_open_dirs = true,
        },

        filters = {
          git_ignored = false,
          dotfiles = false,
          git_clean = false,
          no_buffer = false,
          no_bookmark = false,
          custom = {},
          exclude = {},
        },

        live_filter = {
          prefix = "[FILTER]: ",
          always_show_folders = true,
        },

        filesystem_watchers = {
          enable = true,
          debounce_delay = 50,
          ignore_dirs = {},
        },

        actions = {
          use_system_clipboard = true,
          change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
          },
          expand_all = {
            max_folder_discovery = 300,
            exclude = {},
          },
          file_popup = {
            open_win_config = {
              col = 1,
              row = 1,
              relative = "cursor",
              border = "shadow",
              style = "minimal",
            },
          },
          open_file = {
            quit_on_open = false,
            eject = true,
            resize_window = true,
            window_picker = {
              enable = true,
              picker = "default",
              chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
              exclude = {
                filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                buftype = { "nofile", "terminal", "help" },
              },
            },
          },
          remove_file = {
            close_window = true,
          },
        },

        trash = {
          cmd = "gio trash",
        },

        tab = {
          sync = {
            open = false,
            close = false,
            ignore = {},
          },
        },

        notify = {
          threshold = vim.log.levels.INFO,
          absolute_path = true,
        },

        help = {
          sort_by = "key",
        },

        ui = {
          confirm = {
            remove = true,
            trash = true,
            default_yes = false,
          },
        },

        experimental = {},

        log = {
          enable = false,
          truncate = false,
          types = {
            all = false,
            config = false,
            copy_paste = false,
            dev = false,
            diagnostics = false,
            git = false,
            profile = false,
            watcher = false,
          },
        },
      })
    end,
  },

  -- to make the nvim-tree buffer name.
  {
    "akinsho/bufferline.nvim",
    -- optional = true,
    -- opts = {
    --   options = {
    --     offsets = {
    --       {
    --         filetype = "NvimTree",
    --         text = "File Explorer",
    --         highlight = "Directory",
    --         text_align = "center",
    --         separator = true, -- use a "true" to enable the default, or set your own character
    --       },
    --     },
    --   },
    -- },
    opts = function(_, opts)
      table.insert(opts.options.offsets, {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "center",
        separator = true, -- use a "true" to enable the default, or set your own character
      })
    end,
  },

  {
    "folke/which-key.nvim",
    opts = function(_, _)
      local wk = require("which-key")
      local mapping = {
        { "<leader>e", icon = "󱁕", group = printf("Nvim-Tree"), mode = "n" },
      }
      wk.add(mapping)
    end,
  },

  -- FIX: still not working. both bufferline code above works. but not for lualine.
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   -- opts = function(_, opts)
  --   --   -- require("table").insert(opts.sections.lualine_x, "😄")
  --   --   opts.sections.lualine_a = {}
  --   -- end,
  --   -- config = function () -- FIX: this will overwrite like usual.
  --   --
  --   --   require("lualine").setup({
  --   --   sections = {
  --   --     lualine_a = { },
  --   --   }})
  --   -- end
  -- },
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   opts = function(_, opts)
  --     table.remove(opts.sections.lualine_c, 1)
  --   end,
  -- },
}
