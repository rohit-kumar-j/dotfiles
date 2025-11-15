return {
  "andrewferrier/wrapping.nvim",
  enabled = vim.api.nvim_get_var("useWrapping"),
  event = "BufReadPre",
  config = function()
    require("wrapping").setup()
    vim.keymap.set("n", "<leader>W", "<cmd>lua require('wrapping').toggle_wrap_mode()<CR>", { desc = "Toggle Line Wrap", silent = true })
  end
}
