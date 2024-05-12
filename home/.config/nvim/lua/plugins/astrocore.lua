-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

-- default mappings:
-- ~/.local/share/nvim/lazy/AstroNvim/lua/astronvim/plugins/_astrocore_mappings.lua
-- ~/.local/share/nvim/lazy/AstroNvim/lua/astronvim/plugins/_astrolsp_mappings.lua

_G.qftf = require("core.utils.ui").qftf

local keymap_utils = require "core.utils.keymap"
local normal_command = keymap_utils.normal_command
local lua_normal_command = keymap_utils.lua_normal_command

local is_available = require("astrocore").is_available
local get_icon = require("astroui").get_icon

local function smart_default(cmd, expr)
  return function()
    local word = vim.fn.expand(expr or "<cword>")
    if #word > 1 and not (vim.tbl_contains({ 2, 3 }, #word) and string.find(word, '[",()]')) then
      -- meaningful word, exclude word with short len & contains [,()]
      vim.cmd(string.format("Telescope %s default_text=%s", cmd, word))
    else
      vim.cmd("Telescope " .. cmd)
    end
  end
end

local function visual_search(cmd)
  return function()
    local utils = require "core.utils"
    local content = utils.get_visual_selection()
    if content == nil then return end
    local command = string.format("Telescope %s default_text=%s", cmd, vim.fn.escape(content, " ()"))
    vim.cmd(command)
  end
end

local function commented_lines_textobject()
  local U = require "Comment.utils"
  local cl = vim.api.nvim_win_get_cursor(0)[1] -- current line
  local range = { srow = cl, scol = 0, erow = cl, ecol = 0 }
  local ctx = {
    ctype = U.ctype.linewise,
    range = range,
  }
  local cstr = require("Comment.ft").calculate(ctx) or vim.bo.commentstring
  local ll, rr = U.unwrap_cstr(cstr)
  local padding = true
  local is_commented = U.is_commented(ll, rr, padding)

  local line = vim.api.nvim_buf_get_lines(0, cl - 1, cl, false)
  if next(line) == nil or not is_commented(line[1]) then return end

  local rs, re = cl, cl -- range start and end
  repeat
    rs = rs - 1
    line = vim.api.nvim_buf_get_lines(0, rs - 1, rs, false)
  until next(line) == nil or not is_commented(line[1])
  rs = rs + 1
  repeat
    re = re + 1
    line = vim.api.nvim_buf_get_lines(0, re - 1, re, false)
  until next(line) == nil or not is_commented(line[1])
  re = re - 1

  vim.fn.execute("normal! " .. rs .. "GV" .. re .. "G")
end
---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    ---@type AstroCoreMappings
    local maps = opts.mappings
    ---@type AstroCoreMappings
    local original_maps_to_modify = {
      n = {
        -- ["<Leader>w"] = false,
        ["<Leader>q"] = false,
        ["<Leader>Q"] = false,
        -- ["<Leader>n"] = false,
        ["<C-s>"] = false,
        ["<C-q>"] = false,
        -- ["|"] = false,
        ["\\"] = false, -- Disable default h split


        -- ["<Leader>bc"] = false,
        -- ["<Leader>bC"] = false,
        -- ["<Leader>bd"] = false,
        -- ["<Leader>bD"] = false,
        -- ["<Leader>b\\"] = false,
        -- ["<Leader>b|"] = false,
        -- ["<Leader>bl"] = false,
        -- ["<Leader>bp"] = false,
        -- ["<Leader>br"] = false,
        -- ["<Leader>bs"] = false,
        -- ["<Leader>bse"] = false,
        -- ["<Leader>bsr"] = false,
        -- ["<Leader>bsp"] = false,
        -- ["<Leader>bsi"] = false,
        -- ["<Leader>bsm"] = false,
        --
        ["<Leader>c"] = false,
        ["<Leader>C"] = false,
        [">b"] = false,
        ["<b"] = false,

        -- ["<Leader>/"] = false,

        ["<Leader>o"] = false,

        -- ["<C-h>"] = false,
        -- ["<C-j>"] = false,
        -- ["<C-k>"] = false,
        -- ["<C-l>"] = false,
        -- ["<C-Up>"] = false,
        -- ["<C-Down>"] = false,
        -- ["<C-Left>"] = false,
        -- ["<C-Right>"] = false,

        ["<Leader>lS"] = false,
        ["<Leader>ls"] = { desc = "Document symbols" },
        -- Terminal
        ["<Leader>tn"] = false,

        -- Custom menu for modification of the user experience
        -- ["<Leader>uc"] = false,
        -- ["<Leader>uC"] = false,
        -- ["<Leader>ug"] = false,
        -- ["<Leader>ul"] = false,
        -- ["<Leader>uL"] = false,
        -- ["<Leader>un"] = false,
        -- ["<Leader>uN"] = false,
        -- ["<Leader>up"] = false,
        -- ["<Leader>ut"] = false,
        -- ["<Leader>uu"] = false,
        -- ["<Leader>uy"] = false,

        -- Debug
        ["<Leader>dE"] = false,
        ["<Leader>dd"] = false,
        ["<Leader>ds"] = false,
      },
      i = {
        ["<C-s>"] = false,
      },
      x = {
        ["<C-s>"] = false,
      },
      v = {
        ["<Leader>/"] = false,
      },
      t = {
        ["<C-h>"] = false,
        ["<C-j>"] = false,
        ["<C-k>"] = false,
        ["<C-l>"] = false,
      },
    }
    ---@type AstroCoreMappings
    local new_maps = {
      -- first key is the mode
      n = {
        ["<Leader>\\"] = { "<Cmd>vsplit<CR>", desc = "Vertical Split" },
        -- Git
        dp = {
          function()
            if vim.o.diff then
              vim.cmd.diffput()
            else
              require("gitsigns").stage_hunk()
            end
          end,
          desc = "Diff Put | Stage Hunk",
        },
        dP = {
          function() require("gitsigns").undo_stage_hunk() end,
          desc = "Undo Stage Hunk",
        },
        ["do"] = {
          function()
            if vim.o.diff then
              vim.cmd.diffget()
            else
              require("gitsigns").reset_hunk()
            end
          end,
          desc = "Diff Get | Reset Hunk",
        },

        -- Next / Prev
        ["]"] = {
          name = "Next",
          ["e"] = {
            function() vim.diagnostic.goto_next { severity = vim.diagnostic.severity.ERROR } end,
            "Next Error",
          },
          ["q"] = { normal_command "cnext", "Next Quickfix" },
          ["l"] = { normal_command "lnext", "Next Loclist" },
          ["c"] = {
            function()
              for _ = 1, vim.v.count1 do
                if vim.o.diff then
                  vim.cmd.normal { "]c", bang = true }
                elseif is_available "mini.diff" then
                  require("mini.diff").goto_hunk "next"
                elseif is_available "gitsigns.nvim" then
                  require("gitsigns").nav_hunk "next"
                elseif is_available "vim-signify" then
                  vim.cmd [[execute "normal! \<Plug>(signify-next-hunk)"]]
                else
                  vim.notify("No available method for next hunk", vim.log.levels.ERROR)
                end
              end
            end,
            "Next Change | Hunk",
          },
        },
        ["["] = {
          name = "Previous",
          ["e"] = {
            function() vim.diagnostic.goto_prev { severity = vim.diagnostic.severity.ERROR } end,
            "Previous Error",
          },
          ["q"] = { normal_command "cprev", "Previous Quickfix" },
          ["l"] = { normal_command "lprev", "Previous Loclist" },
          ["c"] = {
            function()
              for _ = 1, vim.v.count1 do
                if vim.o.diff then
                  vim.cmd.normal { "[c", bang = true }
                elseif is_available "mini.diff" then
                  require("mini.diff").goto_hunk "prev"
                elseif is_available "gitsigns.nvim" then
                  require("gitsigns").nav_hunk "prev"
                elseif is_available "vim-signify" then
                  vim.cmd [[execute "normal! \<Plug>(signify-prev-hunk)"]]
                else
                  vim.notify("No available method for prev hunk", vim.log.levels.ERROR)
                end
              end
            end,
            "Previous Change | Hunk",
          },
        },

        -- Better window movement
        ["<A-h>"] = { "<C-w>h", desc = "Left Window" },
        ["<A-j>"] = { "<C-w>j", desc = "Down Window" },
        ["<A-k>"] = { "<C-w>k", desc = "Up Window" },
        ["<A-l>"] = { "<C-w>l", desc = "Right Window" },

        -- Other
        ["m<space>"] = { normal_command "delmarks!", desc = "Delete All Marks" },
        ["g?"] = { normal_command "WhichKey", desc = "WhichKey" },

        -- Debug
        ["<Leader>de"] = { function() require("dapui").eval() end, desc = "Evaluate" },

        -- Custom menu for modification of the user experience
        ["<Leader>uc"] = { normal_command "ColorizerToggle", desc = "Colorizer" },
        ["<Leader>uu"] = { normal_command "OverseerToggle", desc = "Overseer" },
        ["<Leader>uq"] = { function() require("core.utils.ui").toggle_quickfix() end, desc = "Quickfix" },
        ["<Leader>ul"] = { function() require("core.utils.ui").toggle_loclist() end, desc = "Loclist" },

        ["<leader>q"] = { normal_command("quit"), desc = "Quit" },

        ["<Leader>T"] = {
          name = get_icon "ActiveTS" .. " Treesitter",
          c = { normal_command "TSConfigInfo", "Config Info" },
          m = { normal_command "TSModuleInfo", "Module Info" },
          t = { normal_command "InspectTree", "Playground" },
          s = { normal_command "TSUpdate", "Update Treesitter Parser" },
          h = { normal_command "Inspect", "Highlight Info" },
        },

        -- Lang
        ["<Leader>ll"] = {
          function()
            if is_available "dropbar.nvim" then
              require("dropbar.api").pick()
            elseif is_available "aerial.nvim" then
              require("aerial").nav_toggle()
            else
              vim.notify("No dropbar or aerial.nvim installed", vim.log.levels.ERROR)
            end
          end,
          desc = "Navigate",
        },

        ["<F1>"] = {
          lua_normal_command "require('core.utils.ui').toggle_colorcolumn()",
          desc = "Toggle Colorcolumn",
        },
      },

      v = {
        ["<"] = { "<gv" },
        [">"] = { ">gv" },

        ["<Leader>"] = {
          ["*"] = { visual_search "live_grep", "Grep" },
          g = maps.n["<Leader>g"],
          f = maps.n["<Leader>f"],
          fh = { visual_search "help_tags", "Find Help" },
          fb = { visual_search "current_buffer_fuzzy_find", "Grep Buffer" },
        },

        -- Debug
        ["<Leader>de"] = { function() require("dapui").eval() end, desc = "Evaluate" },
      },

      t = {
        -- Improved Terminal Navigation
        ["<A-q>"] = { [[<C-\><C-n>]], desc = "Terminal normal mode" },
        ["<A-h>"] = { normal_command "wincmd h", desc = "Terminal left window navigation" },
        ["<A-j>"] = { normal_command "wincmd j", desc = "Terminal down window navigation" },
        ["<A-k>"] = { normal_command "wincmd k", desc = "Terminal up window navigation" },
        ["<A-l>"] = { normal_command "wincmd l", desc = "Terminal right window navigation" },
      },

      o = {
        u = { commented_lines_textobject, desc = "Commented Lines Textobject", silent = true },
      },

      i = {
        ["<C-k>"] = { "<Up>" },
        ["<C-j>"] = { "<Down>" },
        ["<C-h>"] = { "<Left>" },
        ["<C-l>"] = { "<Right>" },
        ["<F1>"] = {
          lua_normal_command "require('core.utils.ui').toggle_colorcolumn()",
          desc = "Toggle Colorcolumn",
        },
      },

      -- FIXME(meijieru): doesn't work
      c = {
        ["<C-k>"] = { "<Up>" },
        ["<C-j>"] = { "<Down>" },
        ["<C-h>"] = { "<Left>" },
        ["<C-l>"] = { "<Right>" },
      },

      -- TODO(meijieru): migrate more
    }

    local override = {
      -- Configure core features of AstroNvim
      features = {
        large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
        autopairs = true,                                 -- enable autopairs at start
        cmp = true,                                       -- enable completion at start
        diagnostics_mode = 3,                             -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
        highlighturl = true,                              -- highlight URLs at start
        notifications = true,                             -- enable notifications at start
      },
      -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
      diagnostics = {
        virtual_text = true,
        underline = true,
      },
      -- vim options can be configured here
      options = {
        opt = {                  -- vim.opt.<key>
          relativenumber = true, -- sets vim.opt.relativenumber
          number = true,         -- sets vim.opt.number
          spell = false,         -- sets vim.opt.spell
          signcolumn = "yes",    -- sets vim.opt.signcolumn to auto
          wrap = false,          -- sets vim.opt.wrap
          showtabline = 1,
          shiftwidth = 4,
          tabstop = 4,
          showbreak = "↳ ",
          grepprg = [[rg --hidden --glob "!.git" --no-heading --smart-case --vimgrep --follow $*]],
          grepformat = "%f:%l:%c:%m",
          -- background = "light",
          splitkeep = "screen",
          -- https://github.com/hrsh7th/nvim-cmp/issues/309
          title = false,
          -- for click handler of `luukvbaal/statuscol.nvim`
          mousemodel = "extend",
          qftf = "{info -> v:lua._G.qftf(info, 'shorten')}",
          swapfile = false,
          clipboard = "",
          fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]],
        },
        g = { -- vim.g.<key>
          -- configure global vim variables (vim.g)
          -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
          -- This can be found in the `lua/lazy_setup.lua` file
        },
      },

      autocmds = {
        q_close_windows = false,
        -- TODO(meijieru): enable for oil.nvim
        neotree_start = false,
        neovide_init = {
          {
            event = "UIEnter",
            desc = "Set neovide related",
            callback = function()
              if require("core.utils").is_neovide() then require("core.utils.env").neovide_setup() end
            end,
          },
        },
      },

      -- Mappings can be configured through AstroCore as well.
      -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
      mappings = vim.tbl_deep_extend("force", maps, original_maps_to_modify, new_maps),
    }
    return vim.tbl_deep_extend("force", opts, override)
  end,
}
