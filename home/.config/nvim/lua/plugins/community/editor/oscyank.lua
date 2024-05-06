return {
  {
    "ojroques/vim-oscyank",
    event = "BufRead",
    cmd = "OSCYankVisual",
    keys = {
        { "\\y", mode = "v" },
    },
    config = function()
        vim.keymap.set("v", "\\y", "<Plug>OSCYankVisual", {
          desc = "[Y]ank [O]ut text to the system clipboard",
        })
    end,
  },
}


