local Remap = require("config.utils")
local noremap = Remap.noremap
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local tnoremap = Remap.tnoremap
local cnoremap = Remap.cnoremap
local xnoremap = Remap.xnoremap
local map = vim.keymap.set


-- Left and right can switch buffers
nnoremap("[b", "<cmd>bprevious<CR>", { desc = "Previous [b]uffer" })
nnoremap("]b", "<cmd>bnext<CR>", { desc = "Next [b]uffer" })

-- Up and down can switch quickfix list
nnoremap("[q", "<cmd>cprevious<CR>", { desc = "Previous [q]uickfix" })
nnoremap("]q", "<cmd>cnext<CR>", { desc = "Next [q]uickfix" })

nnoremap("<leader>q", function()
  local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
  local action = qf_winid > 0 and "cclose" or "copen"
  vim.cmd("botright " .. action)
end, { desc = "Toggle quickfix", noremap = true, silent = true })

-- Make sure to be in the middle of the screen when navigating half page
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
-- Make sure to be in the middle of the screen when searching
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
-- Make sure to stay at current cursor position when joining
nnoremap("J", "mzJ`z")

-- Easier indentation of code blocks.
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- basic, why not before
nnoremap(";", ":")
-- nnoremap(":", ";")
vnoremap(";", ":")
-- vnoremap(":", ";")

-- logical, why vi
nnoremap("Y", "y$")

-- Move with visuals
xnoremap("K", ":m-2<CR>gv=gv")
xnoremap("J", ":m'>+<CR>gv=gv")

-- Don't move on *
nnoremap(
  "*",
  "<cmd>let stay_star_view = winsaveview()<cr>*<cmd>call winrestview(stay_star_view)<cr>",
  { noremap = true, silent = true }
)

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Better window navigation
keymap("n", "<m-h>", "<C-w>h", opts)
keymap("n", "<m-j>", "<C-w>j", opts)
keymap("n", "<m-k>", "<C-w>k", opts)
keymap("n", "<m-l>", "<C-w>l", opts)
keymap("n", "<m-tab>", "<c-6>", opts)


-- Open new vertical split
nnoremap("<leader>v", ":vsplit<CR>", { desc = "Open [v]ertical split" })

-- Remove trailing whitespace on <leader>S
nnoremap("<leader>S", ":%s/\\s\\+$//<cr>:let @/=''<CR>", { desc = "Remove trailing whitespace" })

-- cd to where the file is currently located
nnoremap("<leader>.", ":lcd %:p:h<CR>", { desc = "Change directory to current file" })
