return {
  "RaafatTurki/hex.nvim",
  enabled = vim.api.nvim_get_var("useHexEditor"),
  keys = {
    { "<leader>Hd", "<cmd>lua require('hex').dump()<cr>",     desc = "Hex Dump" },
    { "<leader>Ha", "<cmd>lua require('hex').assemble()<cr>", desc = "Hex Assemble" },
    { "<leader>Ht", "<cmd>lua require('hex').toggle()<cr>",   desc = "Hex Toggle View" },
  },
  config = function()
    require "hex".setup()
    vim.keymap.set("n", "<leader>Hd", "<cmd>lua require('hex').dump()<cr>", { desc = "Hex Dump" })
    vim.keymap.set("n", "<leader>Ha", "<cmd>lua require('hex').assemble()<cr>", { desc = "Hex Assemble" })
    vim.keymap.set("n", "<leader>Ht", "<cmd>lua require('hex').toggle()<cr>", { desc = "Hex Toggle View" })
  end
}
