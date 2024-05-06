local keymap_utils = require "utils.keymap"
local normal_command = keymap_utils.normal_command
local lua_normal_command = keymap_utils.lua_normal_command

return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          -- ["<Leader>gd"] = { normal_command "DiffviewOpen", desc = "Diff View" },
          ["<Leader>gh"] = { normal_command "DiffviewFileHistory", desc = "Diff History" },
          ["<Leader>gH"] = { normal_command "DiffviewFileHistory %", desc = "Diff History (for current file)" },
          -- ["<Leader>gg"] = { function() require("core.utils.git").toggle_fugitive() end, desc = "Toggle Status" },
          ["<Leader>gl"] = { normal_command "Git blame", desc = "Git Blame" },
          ["<Leader>gL"] = { normal_command "Gitsigns toggle_current_line_blame", desc = "Current Line Blame" },
          ["<Leader>gt"] = {
            keymap_utils.chain("Gitsigns toggle_deleted", "Gitsigns toggle_word_diff"),
            desc = "Toggle Inline Diff",
          },
          ["<Leader>gm"] = { normal_command "Telescope git_status", desc = "Modified Files" },
        },
      },
    },
  },
}
