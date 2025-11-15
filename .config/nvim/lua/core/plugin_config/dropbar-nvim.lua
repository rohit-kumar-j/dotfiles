return {
  "Bekaboo/dropbar.nvim",
  enabled = vim.api.nvim_get_var("useDropbar"),
  keys = { { "<leader>D", function() require("dropbar.api").pick() end, desc = "winbar: pick" } },
}
