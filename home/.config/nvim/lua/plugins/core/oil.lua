return {
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    -- keys = { "<leader>o" },
    keys = { "\\o" },
    config = function()
        require("oil").setup({
            default_file_explorer = false,
        })
        vim.keymap.set("n", "<leader>o", ":Oil<CR>", { desc = "Oil" })
    end,
  },
}
