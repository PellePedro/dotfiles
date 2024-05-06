return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  opts = function(_, opts)      -- override the options using lazy.nvim
    opts.section.header.val = { -- change the header section value
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                     ]],
      [[       ████ ██████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      █████████ ███████████████████ ███   ███████████   ]],
      [[     █████████  ███    █████████████ █████ ██████████████   ]],
      [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
      [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
      [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
    }
    opts.section.buttons.val = {
      opts.button("SPC n  ", "  New file"),
      opts.button("SPC SPC", "  Recent Files"),
      opts.button("SPC fg ", "  Git Files"),
      opts.button("SPC q  ", "  Quit"),
    }
  end,
}
