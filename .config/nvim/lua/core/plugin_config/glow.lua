return {
  "ellisonleao/glow.nvim",
  enabled = vim.api.nvim_get_var("useGlowNvim"),
  cmd = "Glow",
  event = "VeryLazy",
  config = function()
    require("glow").setup({
      style = "dark",
      width = 120,  -- maximum width of the Glow window
      height_ratio = 0.7,
      border = "shadow",
    })
  end
}
