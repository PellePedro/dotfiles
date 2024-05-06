return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "stevearc/aerial.nvim",
      "jvgrootveld/telescope-zoxide",
      "crispgm/telescope-heading.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "ptethng/telescope-makefile",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { "<leader>/", false },
      { "\\r",       [[<cmd>lua vim.lsp.buf.rename()<cr>]], desc = "LSP Rename" },
      { "\\2",       [[<cmd>:Telescope buffers<CR>]],       desc = "Buffers", },
      { "\\q",       [[<cmd>:Telescope aerial<CR>]],        desc = "LSP Symbols", },
      {
        "\\s",
        function() require("telescope.builtin").grep_string({ search = vim.fn.input("Grep For > ") }) end,
        desc = "Search for",
      },
      {
        "\\w",
        function() require('telescope.builtin').grep_string({ search = vim.fn.expand("<cword>") }) end,
        desc = "Find word under cursor",
      },
    },
    config = function(_, opts)
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }

      -- Telescope key mappings for files and system tools
      map("n", "<SPACE><SPACE>", function()
        require("telescope.builtin").find_files({
          no_ignore = true,
          hidden = true,
          prompt_title = "All Files",
        })
      end, vim.tbl_extend("force", opts, { desc = "All files" }))

      local telescope_cmds = {
        -- ["<leader>tf"] = "Telescope find_files find_command=rg,--ignore,--hidden,--files",
        ["<leader>tb"] = "Telescope buffers",
        ["<leader>th"] = "Telescope help_tags",
        ["<leader>tm"] = "Telescope marks",
        ["<leader>tr"] = "Telescope registers",
        ["<leader>tt"] = "Telescope treesitter",
        ["<leader>tg"] = "Telescope git_status",
        ["<leader>tgp"] = "Telescope git_files",
        ["<leader>tgc"] = "Telescope git_commits",
        ["<leader>tgb"] = "Telescope git_branches",
        ["<leader>tgs"] = "Telescope git_status",
        ["<leader>tgh"] = "Telescope git_stash",
      }

      for k, cmd in pairs(telescope_cmds) do
        map("n", k, "<cmd>" .. cmd .. "<cr>", vim.tbl_extend("force", opts, { desc = cmd }))
      end

      -- Telescope key mappings for general searching
      local modes = { "n", "l" }
      local search_cmds = {
        ["<d-p>"] = "lua require('telescope').extensions.smart_open.smart_open({ cwd_only = true })",
        ["<c-p>"] = "Telescope fd find_command=rg,--ignore,--hidden,--files,-F",
        ["<d-,>"] = "Telescope live_grep find_command=rg,--ignore,--hidden,--files,-F",
      }

      for k, cmd in pairs(search_cmds) do
        for _, mode in ipairs(modes) do
          map(mode, k, "<cmd>" .. cmd .. "<cr>", vim.tbl_extend("force", opts, { desc = cmd }))
        end
      end

      local telescope = require "telescope"
      local telescopeConfig = require "telescope.config"
      local actions = require "telescope.actions"
      local action_layout = require "telescope.actions.layout"
      local fb_actions = require("telescope").extensions.file_browser.actions

      local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
      if true then table.insert(vimgrep_arguments, "--hidden") end
      -- trim the indentation at the beginning of presented line
      table.insert(vimgrep_arguments, "--trim")

      local fzf_opts = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      }

      require("telescope").setup({
        extensions = {
          smart_open = {
            show_scores = false,
            ignore_patterns = { "*.git/*", "*/tmp/*" },
            match_algorithm = "fzf",
            disable_devicons = false,
            cwd_only = true,
          },
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
        },
        pickers = {
          find_files = {
            hidden = false,
          },
          buffers = {
            ignore_current_buffer = true,
            sort_lastused = true,
            mappings = {
              i = {
                ["<c-d>"] = actions.delete_buffer,
              },
            },
          },
          live_grep = {
            sorter = telescope.extensions.fzf.native_fzf_sorter(fzf_opts),
            only_sort_text = true, -- grep for content and not file name/path
            mappings = {
              i = { ["<c-f>"] = require("telescope.actions").to_fuzzy_refine },
            },
          },
        },
        defaults = {
          -- file_ignore_patterns = settings.telescope_file_ignore_patterns,
          vimgrep_arguments = vimgrep_arguments,
          mappings = {
            i = {
              -- Close on first esc instead of going to normal mode
              -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
              ["<esc>"] = actions.close,
              ["<C-j>"] = actions.move_selection_next,
              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.send_selected_to_qflist,
              ["<C-l>"] = actions.send_to_qflist,
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<cr>"] = actions.select_default,
              ["<c-v>"] = actions.select_vertical,
              ["<c-s>"] = actions.select_horizontal,
              ["<c-t>"] = actions.select_tab,
              ["<c-p>"] = action_layout.toggle_preview,
              ["<c-o>"] = action_layout.toggle_mirror,
              ["<c-h>"] = actions.which_key,
              ["<c-x>"] = actions.delete_buffer,
            },
          },
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "smart" },
          entry_prefix = "  ",
          multi_icon = "<>",
          initial_mode = "insert",
          scroll_strategy = "cycle",
          selection_strategy = "reset",
          -- sorting_strategy = "descending",
          -- layout_strategy = "vertical",
          layout_strategy = "horizontal",
          sorting_strategy = "ascending",
          layout_config = {
            width = 0.95,
            height = 0.85,
            -- preview_cutoff = 120,
            prompt_position = "top",
            horizontal = {
              preview_width = function(_, cols, _)
                if cols > 200 then
                  return math.floor(cols * 0.4)
                else
                  return math.floor(cols * 0.6)
                end
              end,
            },
            vertical = { width = 0.9, height = 0.95, preview_height = 0.5 },
            flex = { horizontal = { preview_width = 0.9 } },
          },
          winblend = 0,
          border = {},
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          color_devicons = true,
          use_less = true,
          set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        },
      })
      require("telescope").load_extension("fzf")
      -- require("telescope").load_extension("file_browser")
    end,
  },
}
