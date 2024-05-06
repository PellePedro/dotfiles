return {
  "nvim-telescope/telescope.nvim",
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
    { "<Leader>fb",       [[<cmd>Telescope buffers<CR>]],    desc = "Find Buffer" },
    { "<Leader>ff",       [[<cmd>Telescope find_files<CR>]], desc = "Find Git File" },
    { "<Leader>fg",       [[<cmd>Telescope git_files<CR>]],  desc = "Find Git File" },
    { "<Leader>fk",       [[<cmd>Telescope keymaps<CR>]],    desc = "Keymaps" },
    { "<Leader>fl",       [[<cmd>Telescope loclist<CR>]],    desc = "Find Loclist" },
    { "<Leader>fp",       [[<cmd>Telescope projects<CR>]],   desc = "Projects" },
    { "<Leader>fq",       [[<cmd>Telescope quickfix<CR>]],   desc = "Find QuickFix" },
    { "<Leader>ft",       [[<cmd>OverseerRun<CR>]],          desc = "Find Tasks" },
    { "<Leader>fj",       [[<cmd>Telescope jumplist<CR>]],   desc = "Find JumpList" },
    { "<Leader><leader>", [[<cmd>Telescope oldfiles<CR>]],   desc = "Open Recent File" },
    { "<Leader>fR",       [[<cmd>Telescope registers<CR>]],  desc = "Find Registers" },
  },
  opts = function(_, opts)
    local actions = require "telescope.actions"
    local action_state = require "telescope.actions.state"

    local function send_and_open_qflist(...)
      actions.smart_send_to_qflist(...)
      actions.open_qflist(...)
    end
    -- useful defalt:
    -- <C-/> Show mappings for picker actions (insert mode)
    -- ? Show mappings for picker actions (normal mode)
    local mappings = opts.defaults.mappings
    mappings.i = {
      ["<C-n>"] = actions.move_selection_next,
      ["<C-p>"] = actions.move_selection_previous,
      ["<C-j>"] = actions.cycle_history_next,
      ["<C-k>"] = actions.cycle_history_prev,
      ["<C-q>"] = send_and_open_qflist,
      ["<CR>"] = actions.select_default,
    }
    mappings.n = {
      ["<C-n>"] = actions.move_selection_next,
      ["<C-p>"] = actions.move_selection_previous,
      ["<C-q>"] = send_and_open_qflist,
      ["g?"] = "which_key",
    }

    local function git_diffview(prompt_bufnr, template)
      -- Open in diffview
      local selected_entry = action_state.get_selected_entry()
      local value = selected_entry.value
      actions.close(prompt_bufnr)
      vim.schedule(function() vim.cmd(template:format(value)) end)
    end
    local function git_diffview_commit(prompt_bufnr) return git_diffview(prompt_bufnr, "DiffviewOpen %s^!") end
    local function git_diffview_branch(prompt_bufnr) return git_diffview(prompt_bufnr, "DiffviewOpen %s") end

    opts.pickers = {
      find_files = {
        hidden = true,
        file_ignore_patterns = { "node_modules", ".git", ".venv" },
      },
      git_commits = {
        mappings = {
          i = {
            ["<C-v>"] = git_diffview_commit,
          },
        },
      },
      git_bcommits = {
        mappings = {
          i = {
            ["<C-v>"] = git_diffview_commit,
          },
        },
      },
      git_branches = {
        mappings = {
          i = {
            ["<C-v>"] = git_diffview_branch,
          },
        },
      },
      buffers = {
        mappings = {
          i = {
            ["<C-d>"] = actions.delete_buffer,
          },
          n = {
            ["dd"] = actions.delete_buffer,
          },
        },
      },
    }

    opts.defaults.path_display = {
      filename_first = {
        reverse_directories = false,
      },
    }
  end,
}
