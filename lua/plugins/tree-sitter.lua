local printf = require("plugins.util.printf").printf

return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- commit = "865483f8d1c6e263a1a9efd46f84e78ec5fa31d4",
    dependencies = {
      { "p00f/nvim-ts-rainbow" }, -- the original rainbow still works fine

      -- treesitter playground
      {
        "nvim-treesitter/playground",
        config = function()
          require("nvim-treesitter.configs").setup({
            playground = {
              enable = true,
              disable = {},
              updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
              persist_queries = false, -- Whether the query persists across vim sessions
              keybindings = {
                toggle_query_editor = "o",
                toggle_hl_groups = "i",
                toggle_injected_languages = "t",
                toggle_anonymous_nodes = "a",
                toggle_language_display = "I",
                focus_language = "f",
                unfocus_language = "F",
                update = "R",
                goto_node = "<cr>",
                show_help = "?",
              },
            },
          })
        end,
        keys = {
          {
            "<leader>bt",
            function()
              vim.cmd("TSPlaygroundToggle")
            end,
            desc = printf("Toggle Treesitter Playground"),
          },
          {
            "<leader>bh",
            function()
              vim.cmd("TSHighlightCapturesUnderCursor")
            end,
            desc = printf("Toggle Highlight Capture"),
          },
        },
      },
      {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
          if type(opts.ensure_installed) == "table" then
            vim.list_extend(opts.ensure_installed, { "query" })
          end

          opts.auto_install = true
        end,
      },

      {
        "nvim-treesitter/nvim-treesitter-context",
        -- enabled = false,
        config = function()
          require("treesitter-context").setup({
            enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
            max_lines = 5, -- How many lines the window should span. Values <= 0 mean no limit.
            min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
            line_numbers = true,
            multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
            trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
            mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
            -- Separator between context and content. Should be a single character string, like '-'.
            -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
            -- separator = "‾",
            separator = "─",
            -- separator = nil,
            zindex = 20, -- The Z-index of the context window
            on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
          })

          vim.cmd.highlight("TreesitterContextSeparator guifg=#414d59")
          vim.cmd.highlight("TreesitterContextBottom guibg=NONE guifg=NONE gui=NONE") -- NOTE: to remove the underline which is not working in tmux. causing colored underline that matches the string.
        end,

        keys = {
          {
            "<leader>cg",
            function()
              require("treesitter-context").go_to_context()
            end,
            mode = { "n", "v" },
            desc = printf("Go to Context"),
          },
        },
      },
    },

    opts = {
      -- NOTE: very usefull. it will do a 'viw' but a in more advance way as it uses treesitter
      incremental_selection = {
        enable = true,
        keymaps = {
          -- NOTE: change this to not conflict with keybind
          init_selection = "<S-Enter>",
          node_incremental = "<S-Enter>",
          node_decremental = "<S-BS>",
        },
      },

      highlight = {
        enable = true,
      },

      rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
      },
    },
  },
}
