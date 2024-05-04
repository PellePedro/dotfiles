local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

-- Remap space as leader key
-- Must be before lazy
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>ml", "<cmd>Lazy<cr>")

require("lazy").setup({
  { "LazyVim/LazyVim",                               import = "lazyvim.plugins" },
  { import = "core.plugins.extras.editor.aerial" },
  { import = "core.plugins.extras.editor.trouble-v3" },
  { import = "core.plugins" },
  -- defaults = { lazy = true },
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = false, -- get a notification when changes are found
  },
  debug = false,
})
