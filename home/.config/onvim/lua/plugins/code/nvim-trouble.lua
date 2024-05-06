return {
  "folke/trouble.nvim",
  keys = {
    {
      "\\t",
      [[<cmd>:TroubleToggle<cr>]],
      desc = "Troubles"
    },
  },
  opts = {
    defaults = {
      mode = "lsp_document_diagnostics",
      signs = {
        error = "",
        warning = "",
        hint = "",
        information = "",
      },
      auto_preview = true,
      auto_fold = true,
      use_lsp_diagnostic_signs = true,
    },
  },
}
