return {
  "axieax/urlview.nvim",
  enabled = vim.api.nvim_get_var("useURLView"),
  event = "VeryLazy",
  config = function()
    -- require("leap").add_default_mappings()
    require("urlview").setup({
      default_picker = "telescope",
    })
  end
}
