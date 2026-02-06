return {
  url  = "https://codeberg.org/andyg/leap.nvim.git",
  enabled = vim.api.nvim_get_var("useLeap"),
  event = "BufReadPre",
  config = function()
    require("leap").add_default_mappings()
  end
}
