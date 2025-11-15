return {
  "folke/twilight.nvim",
  enabled = vim.api.nvim_get_var("useTwilight"),
  keys = {
    { "<leader>zt", "<cmd>Twilight<CR>", desc = "Twilight" }
  },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function()
    vim.keymap.set("n", "<leader>zt", "<cmd>Twilight<CR>", { desc = "Twilight" })
  end
}
