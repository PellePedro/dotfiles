-- Use most plugins only on my local machine
local host = "mbp"

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  -- { import = "astrocommunity.pack.go" },
  -- { import = "astrocommunity.colorscheme.catppuccin", enabled = true },
  -- { import = "astrocommunity.completion.copilot-lua", enable = (vim.fn.hostname() == host) },
  -- { import = "astrocommunity.project.nvim-spectre",   enabled = true },

  -- import/override with your plugins folder
}
