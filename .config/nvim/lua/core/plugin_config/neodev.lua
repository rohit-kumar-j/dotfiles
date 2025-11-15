return {
  "folke/neodev.nvim",
  enabled = vim.api.nvim_get_var("useLSP"),
  event = "InsertEnter",
  ft = { "lua" },
  config = function()
    require("neodev").setup({})
  end
}
