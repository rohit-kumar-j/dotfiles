return {
  "rmagatti/goto-preview",
  enabled = vim.api.nvim_get_var("useGotoPreview"),
  event = "LspAttach",
  config = function()
    require("goto-preview").setup {}
    vim.keymap.set("n", "<leader><leader>d",
      "<cmd>lua require ('goto-preview').goto_preview_definition()<cr>", { desc = "Definition" })
    vim.keymap.set("n", "<leader><leader>T",
      "<cmd>lua require ('goto-preview').goto_preview_type_definition()<cr>", { desc = "Type Definition" })
    vim.keymap.set("n", "<leader><leader>i",
      "<cmd>lua require ('goto-preview').goto_preview_implementation()<cr>", { desc = "Implementation" })
    vim.keymap.set("n", "<leader><leader>r",
      "<cmd>lua require ('goto-preview').goto_preview_references()<cr>", { desc = "References" })
  end
}
