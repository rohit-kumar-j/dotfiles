return {
  "ThePrimeagen/harpoon",
  enabled = vim.api.nvim_get_var("useHarpoon"),
  -- event = "VeryLazy",
  keys = {
    { "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>",        desc = "Add file to Harpoon" },
    { "<leader>hs", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Toggle Harpoon Menu" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function()
    require("harpoon").setup({
      menu = {
        width = vim.api.nvim_win_get_width(0) - 10,
      }
    })
    -- vim.keymap.set("n", "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>", {desc = "Add file to Harpoon"})
    -- vim.keymap.set("n", "<leader>hs", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", {desc = "Toggle Harpoon Menu"})
    vim.keymap.set("n", "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<cr>", { desc = "Next Harpoon Mark" })
    vim.keymap.set("n", "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", { desc = "Prev Harpoon Mark" })
    vim.keymap.set("n", "<leader>n", "<cmd>lua require('harpoon.ui').nav_next()<cr>", { desc = "Next Harpoon Mark" })
    vim.keymap.set("n", "<leader>p", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", { desc = "Prev Harpoon Mark" })
  end
}
