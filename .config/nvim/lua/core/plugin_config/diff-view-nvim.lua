return {
  "sindrets/diffview.nvim",
  enabled = vim.api.nvim_get_var("useDiffViewNvim"),
  event = "BufReadPre",
  config = true
}
