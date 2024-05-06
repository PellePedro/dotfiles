return {
  {
    -- Better yanking across ssh sessions
    "ojroques/vim-oscyank",
    event = "BufRead",
    -- branch = "main",
    cmd = { "OSCYankVisual" },
    config = function()
      vim.keymap.set("n", "\\y", "<Plug>OSCYankVisual")
      vim.keymap.set("v", "\\y", "<Plug>OSCYankVisual")
    end,
  },
}

