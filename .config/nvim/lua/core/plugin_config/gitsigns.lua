return {
  "lewis6991/gitsigns.nvim",
  enabled = vim.api.nvim_get_var("useGitSigns"),
  event = "BufReadPre",
  config = function()
    require("gitsigns").setup({
      current_line_blame = true
    })

    vim.keymap.set("n", "<leader>gj",
      "<cmd>lua require ('gitsigns').next_hunk({navigation_message = false})<cr>", { desc = "Next Hunk" })
    vim.keymap.set("n", "<leader>gk",
      "<cmd>lua require ('gitsigns').prev_hunk({navigation_message = false})<cr>", { desc = "Prev Hunk" })
    vim.keymap.set("n", "<leader>gl",
      "<cmd>lua require ('gitsigns').blame_line()<cr>", { desc = "Blame" })
    vim.keymap.set("n", "<leader>gP",
      "<cmd>lua require ('gitsigns').preview_hunk()<cr>", { desc = "Preview Hunk" })

    vim.keymap.set("n", "<leader>gr",
      "<cmd>lua require ('gitsigns').reset_hunk()<cr>", { desc = "Reset Hunk" })
    vim.keymap.set("n", "<leader>gR",
      "<cmd>lua require ('gitsigns').reset_buffer()<cr>", { desc = "Reset Buffer" })
    vim.keymap.set("n", "<leader>gs",
      "<cmd>lua require ('gitsigns').stage_hunk()<cr>", { desc = "Stage Hunk" })
    vim.keymap.set("n", "<leader>gu",
      "<cmd>lua require ('gitsigns').undo_stage_hunk()<cr>", { desc = "Undo Stage Hunk" })
    vim.keymap.set("n", "<leader>gd",
      "<cmd>Gitsigns diffthis HEAD<cr>", { desc = "Git Diff" })
  end
}
