return {
  "dhruvasagar/vim-table-mode",
  enabled = vim.api.nvim_get_var("useVimTableMode"),
  ft = { "markdown" },
  config = function()
    vim.g.table_mode_map_prefix = "<leader>T"  -- isolate to <leader>T prefix
    vim.g.table_mode_toggle_map = "T"           -- so toggle = <leader>TT
    vim.keymap.set("n", "<leader>TT", "<cmd>TableModeToggle<cr>", { desc = "TableMode Toggle" })
    vim.keymap.set("n", "<leader>TR", "<cmd>TableModeRealign<cr>", { desc = "TableMode Realign" })
  end
  --- Commands
  -- :TableMode<Enable>
  -- :TableMode<Disable>
}
