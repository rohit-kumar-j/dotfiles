return {
  "b0o/incline.nvim",
  event = "BufReadPre",
  enabled = vim.api.nvim_get_var("useIncline"),
  config = function()
    require("incline").setup()
  end
}
