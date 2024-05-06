return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "AstroNvim/astrolsp", opts = {} },
      {
        "williamboman/mason-lspconfig.nvim", -- MUST be set up before `nvim-lspconfig`
        dependencies = { "williamboman/mason.nvim" },
        opts = function()
          return {
            -- use AstroLSP setup for mason-lspconfig
            handlers = {
              function(server)
                require("astrolsp").lsp_setup(server)
              end,
            },
          }
        end,
      },
    },
    config = function()
      -- set up servers configured with AstroLSP
      vim.tbl_map(require("astrolsp").lsp_setup, require("astrolsp").config.servers)
    end,
  },

  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    opts = function()
      return { on_attach = require("astrolsp").on_attach }
    end,
    config = function()
      require("lsp_signature").setup({
        toggle_key = "M-t",
        select_signature_key = "M-n",

        bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
          border = "rounded",
        },

        hint_inline = function()
          return false
        end,

        hint_enable = false, -- disable hints as it will crash in some terminal
      })
    end,
  },

  {
    "lvimuser/lsp-inlayhints.nvim",
    init = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end

          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client.server_capabilities.inlayHintProvider then
            local inlayhints = require("lsp-inlayhints")
            inlayhints.on_attach(client, args.buf)

            require("astrocore").set_mappings({
              n = {
                ["<leader>uH"] = { inlayhints.toggle, desc = "Toggle inlay hints" },
              },
            }, { buffer = args.buf })
          end
        end,
      })
    end,
    config = function()
      require("lsp-inlayhints").setup({
        inlay_hints = {
          parameter_hints = {
            show = true,
            prefix = "<- ",
            separator = ", ",
            remove_colon_start = false,
            remove_colon_end = true,
          },
          type_hints = {
            -- type and other hints
            show = true,
            prefix = "",
            separator = ", ",
            remove_colon_start = false,
            remove_colon_end = false,
          },
          only_current_line = false,
          -- separator between types and parameter hints. Note that type hints are
          -- shown before parameter
          labels_separator = "  ",
          -- whether to align to the length of the longest line in the file
          max_len_align = false,
          -- padding from the left if max_len_align is true
          max_len_align_padding = 1,
          -- highlight group
          highlight = "LspInlayHint",
          -- virt_text priority
          priority = 0,
        },
        enabled_at_startup = true,
        debug_mode = false,
      })
    end,
  },
  {
    "p00f/clangd_extensions.nvim",
    optional = true,
    opts = { extensions = { autoSetHints = false } },
  },
  {
    "simrat39/rust-tools.nvim",
    optional = true,
    opts = { tools = { inlay_hints = { auto = false } } },
  },
}
