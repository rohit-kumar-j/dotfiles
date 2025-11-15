return {
  "ggandor/leap.nvim",
  enabled = vim.api.nvim_get_var("useLeap"),
  event = "BufReadPre",
  config = function()
    require("leap").add_default_mappings()
  end
}
