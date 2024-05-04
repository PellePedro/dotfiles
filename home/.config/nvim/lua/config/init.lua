local function init()
  -- autocmds
  -- require("config.autocmds")
  -- globals
  -- require("utils.globals")
  -- lazy.nvim
  require("config.lazy")
  -- global mappings (must be loaded after lazy)
   require("config.mappings")
end

init()

