-- For Testing, remove the ~ sign before the `:`

-- FIX: This is the default setting
-- FIXME: This is the default setting
-- BUG: This is the default setting
-- FIXIT: This is the default setting
-- ISSUE: This is the default setting
-- TODO: This is the default setting
-- HACK: This is the default setting
-- XXX: This is the default setting
-- WARN: This is the default setting
-- PERF: This is the default setting
-- OPTIM: This is the default setting
-- PERFORMANCE: This is the default setting
-- OPTIMIZE: This is the default setting
-- NOTE: This is the default setting
-- INFO: This is the default setting
-- TEST: This is the default setting
-- PASSED: This is the default setting
-- FAILED: This is the default setting

return {
  "folke/todo-comments.nvim",
  enabled = vim.api.nvim_get_var("useTODOList"),
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "BufReadPre",
  keys = {
    { "<leader>tt", "<cmd>TodoTelescope<cr>",       desc = "Todo List" },
    { "<leader>th", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
  },
  config = function()
    require("todo-comments").setup(
      {
        signs = true,      -- show icons in the signs column
        sign_priority = 8, -- sign priority
        -- keywords recognized as todo comments
        keywords = {
          FIX = {
            icon = " ",
            color = "error",
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
          },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = {
            icon = " ",
            color = "warning",
            alt = { "WARNING", "XXX" }
          },
          PERF = {
            icon = " ",
            alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" }
          },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
          TEST = { icon = "⏲ ", color = "test" },
          PASSED = { icon = "✓ ", color = "passed" },
          FAILED = { icon = "✘", color = "failed" }
        },
        gui_style = {
          fg = "NONE",
          bg = "BOLD",
        },
        merge_keywords = true,
        highlight = {
          multiline = true, -- enable multine todo comments
          multiline_pattern = "^.",
          multiline_context = 10,
          before = "", -- "fg" or "bg" or empty
          keyword = "wide_fg",
          after = "fg",
          pattern = [[.*<(KEYWORDS)\s*:]],
          comments_only = true,
          max_line_len = 400,
          exclude = {},
        },
        colors = {
          error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
          warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
          info = { "DiagnosticInfo", "#2563EB" },
          hint = { "DiagnosticHint", "#10B981" },
          default = { "Identifier", "#7C3AED" },
          test = { "Identifier", "#FF00FF" },
          passed = { "Identifier", "#2563EB" },
          failed = { "Identifier", "#FD0000" }
        },
        search = {
          command = "rg",
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--glob=!node_modules",
            "--glob=!external",
            "--glob=!build",
          },
          -- regex that will be used to match keywords.
          -- don't replace the (KEYWORDS) placeholder
          pattern = [[\b(KEYWORDS):]], -- ripgrep regex
        },
      }
    )
    vim.keymap.set("n", "<leader>tt", "<cmd>TodoTelescope<cr>", { desc = "Todo List" })
    vim.keymap.set("n", "<leader>th", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })
  end
}
