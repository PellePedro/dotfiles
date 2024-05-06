local prefix = "<leader>x"
local maps = { n = {} }
local icon = vim.g.icons_enabled and "󱍼 " or ""
maps.n[prefix] = { desc = icon .. "Trouble" }
require("astrocore").set_mappings(maps)

return {
  {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["\\t"] = {
            "<cmd>TroubleToggle <cr>",
            desc = "(Trouble)",
          },
          [prefix .. "X"] = {
            "<cmd>TroubleToggle workspace_diagnostics<cr>",
            desc = "Workspace Diagnostics (Trouble)",
          },
          [prefix .. "x"] = {
            "<cmd>TroubleToggle document_diagnostics<cr>",
            desc = "Document Diagnostics (Trouble)",
          },
          [prefix .. "l"] = {
            "<cmd>TroubleToggle loclist<cr>",
            desc = "Location List (Trouble)",
          },
          [prefix .. "q"] = {
            "<cmd>TroubleToggle quickfix<cr>",
            desc = "Quickfix List (Trouble)",
          },
        },
      },
    },
  },

  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = {
      use_diagnostic_signs = true,
      action_keys = {
        close = { "q", "<esc>" },
        cancel = "<c-e>",
      },
      keys = {
        {
          ["\\t"] = {
            "<cmd>TroubleToggle <cr>",
            desc = "(Trouble)",
          },
          {
            "[q",
            function()
              if require("trouble").is_open() then
                require("trouble").previous({ skip_groups = true, jump = true })
              else
                local ok, err = pcall(vim.cmd.cprev)
                if not ok then
                  vim.notify(err, vim.log.levels.ERROR)
                end
              end
            end,
            desc = "Previous trouble/quickfix item",
          },
          {
            "]q",
            function()
              if require("trouble").is_open() then
                require("trouble").next({ skip_groups = true, jump = true })
              else
                local ok, err = pcall(vim.cmd.cnext)
                if not ok then
                  vim.notify("failed to jump to next trouble", vim.log.levels.ERROR)
                end
              end
            end,
            desc = "Next trouble/quickfix item",
          },
        },
      },
    },
  },
  -- {
  --   "folke/edgy.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     if not opts.bottom then
  --       opts.bottom = {}
  --     end
  --     table.insert(opts.bottom, "Trouble")
  --   end,
  -- },

  {
    "catppuccin/nvim",
    optional = true,
    opts = { integrations = { lsp_trouble = true } },
  },
}
