return {
  {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<leader>fz"] = { "<cmd>Telescope zoxide list<CR>", desc = "Find directories" },
        },
      },
    },
  },

  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
      {
        "jvgrootveld/telescope-zoxide",
        dependencies = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
        config = function()
          require("telescope").load_extension("zoxide")
        end,
      },
    },
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        winblend = 0,
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
      },
      extensions = {
        zoxide = {
          prompt_title = "[ Walking on the shoulders of TJ ]",
        },
      },
    },
    -- config = function(_, opts)
    --   local telescope = require("telescope")
    --   telescope.setup(opts)

    --   if pcall(require, "zoxide") then
    --     pcall(telescope.load_extension, "zoxide")
    --   end

    --   if pcall(require, "notify") then
    --     pcall(telescope.load_extension, "notify")
    --   end

    --   if pcall(require, "aerial") then
    --     pcall(telescope.load_extension, "aerial")
    --   end

    --   if require("astrocore").is_available("telescope-fzf-native.nvim") then
    --     pcall(telescope.load_extension, "fzf")
    --   end
    -- end,
  },
}
