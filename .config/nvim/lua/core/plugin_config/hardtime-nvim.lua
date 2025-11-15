return {
  "m4xshen/hardtime.nvim",
  enabled = vim.api.nvim_get_var("useHardtime"),
  event = "VeryLazy",
  opts = {
    disabled_filetypes = { "qf", "netrw", "NvimTree",
      "lazy", "mason", "cmake_tools_terminal",
      "terminal", "dashboard", "dapui_stacks",
      "dapui_console", "dapui-repl", "dapui_watches",
      "dapui_breakpoints"
    },
  }
}
