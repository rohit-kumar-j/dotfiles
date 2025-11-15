return {
  "ckipp01/stylua-nvim",
  enabled = vim.api.nvim_get_var("useStylua"),
  ft = { "lua" },
  build = "cargo install stylua"
}
