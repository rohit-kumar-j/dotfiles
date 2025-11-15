return {
  "stevearc/conform.nvim",
  enabled = true, --vim.api.nvim_get_var("useLSP"),
  event = "InsertEnter",
  opts = {
    -- Fix: should be formatters_by_ft, not format_by_ft
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
    },
    -- Remove format_on_save from here since you're handling it manually
    log_level = vim.log.levels.ERROR,
    notify_on_error = true,
    notify_no_formatters = true,
  },
}
